import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/app_locking/model/app_locked.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:score_keeper/app_locking/model/app_locked_state.dart';
import 'package:score_keeper/app_locking/providers/app_locked_providers.dart';

class AppLockedStateNotifier extends StateNotifier<AppLockedState> {
  AppLockedStateNotifier(this.ref) : super(AppLockedState.regularState) {
    final stream = ref.read(appLockedReferenceProvider).snapshots();
    _appLockedSubscription = stream.listen(_onAppLockedSubscription);
  }

  final Ref ref;

  late StreamSubscription<DocumentSnapshot<AppLocked>> _appLockedSubscription;

  void _onAppLockedSubscription(DocumentSnapshot<AppLocked> snapshot) async {
    if (snapshot.exists) {
      final data = snapshot.data()!;
      if (data.isDown) {
        state = AppLockedState.maintenanceMode;
      } else {
        final int minVersionNumber = Platform.isIOS ? data.ios : data.android;
        _verifyAppVersion(minVersionNumber);
      }
    } else {
      resetState();
    }
  }

  Future<void> _verifyAppVersion(int minVersionNumber) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final deviceVersion = int.tryParse(packageInfo.buildNumber) ?? -1;
    final bool isNotValidVersion = minVersionNumber > deviceVersion ;
    if (isNotValidVersion) {
      state = AppLockedState.upgradeRequired;
    } else {
      resetState();
    }
  }

  Future<void> close() async {
    await _appLockedSubscription.cancel();
  }

  void resetState() => state = AppLockedState.regularState;
}

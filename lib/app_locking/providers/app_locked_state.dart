import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/app_locking/model/app_locked.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:score_keeper/app_locking/providers/app_locked_providers.dart';

enum AppLockedState {
  regularState,
  upgradeRequired,
  maintenanceMode,
}

class AppLockedStateNotifier extends StateNotifier<AppLockedState> {
  AppLockedStateNotifier(this.ref) : super(AppLockedState.regularState) {
    final stream = ref.read(appLockedReferenceProvider).snapshots();
    _appLockedSubscription = stream.listen(_onAppLockedSubscription);
  }

  final Ref ref;

  late StreamSubscription<DocumentSnapshot<AppLocked>> _appLockedSubscription;

  void _onAppLockedSubscription(DocumentSnapshot<AppLocked> snapshot) async {
    print('=== snapshot _onAppLockedSubscription: $snapshot');

    if (snapshot.exists) {
      print('=== data: ${snapshot.data()}');
      final data = snapshot.data()!;
      if (data.isDown) {
        print('=== Maintenance Mode');
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

    print('=== deviceVersion: $deviceVersion | minVersionNumber: $minVersionNumber');

    final bool isNotValidVersion = minVersionNumber > deviceVersion ;

    if (isNotValidVersion) {
      print('=== Upgrade Required');
      state = AppLockedState.upgradeRequired;
    } else {
      print('=== No App Locked');
      resetState();
    }
  }

  Future<void> close() async {
    await _appLockedSubscription.cancel();
  }

  void resetState() => state = AppLockedState.regularState;
}

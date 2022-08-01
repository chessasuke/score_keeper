import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/app_locking/firestore/firestore_collection_keys.dart';
import 'package:score_keeper/app_locking/firestore/firestore_document_keys.dart';
import 'package:score_keeper/app_locking/model/app_locked.dart';
import 'package:score_keeper/app_locking/providers/app_locked_state.dart';

final appLockedReferenceProvider = Provider<DocumentReference<AppLocked>>(
  (ref) {
    final appLockedData = FirebaseFirestore.instance
        .collection(FirestoreCollectionKeys.config)
        .doc(FirestoreDocumentKeys.appLockedService)
        .withConverter<AppLocked>(
          fromFirestore: AppLocked.fromFirestore,
          toFirestore: (model, _) => model.toJson(),
        );
    return appLockedData;
  },
);

final appLockedProviderNotifier =
    StateNotifierProvider.autoDispose<AppLockedStateNotifier, AppLockedState>(
        (ref) {
  final appLockedNotifier = AppLockedStateNotifier(ref);
  ref.onDispose(() async {
    await appLockedNotifier.close();
  });
  ref.maintainState = true;
  return appLockedNotifier;
});

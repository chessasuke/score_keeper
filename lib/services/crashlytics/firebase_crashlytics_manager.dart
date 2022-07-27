import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final crashlyticsProvider = Provider((ref) => FirebaseCrashlyticsManager());

class FirebaseCrashlyticsManager {
  FirebaseCrashlyticsManager() {
    init();
  }

  Future<void> init() async {
    /// Crashlytics is not yet supported on web
    if (!kIsWeb) {
      _firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = _firebaseCrashlytics.recordFlutterError;
    }
  }

  final FirebaseCrashlytics _firebaseCrashlytics = FirebaseCrashlytics.instance;

  Future<void> recordError({
    required Object exception,
    StackTrace? stackTrace,
    String? reason,
  }) async {
    if (!kIsWeb) {
      return _firebaseCrashlytics.recordError(
        exception,
        stackTrace,
        reason: reason,
      );
    }
  }
}

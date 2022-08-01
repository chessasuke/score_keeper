import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/app_locking/widgets/app_locked_service_consumer.dart';
import 'package:score_keeper/firebase_options.dart';
import 'package:score_keeper/generated/i18n.dart';
import 'navigator/route_parser.dart';
import 'navigator/router_delegate.dart';
import 'services/logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  if (!kIsWeb) {
    runZonedGuarded<Future<void>>(() async {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(
        ProviderScope(
          observers: [Logger()],
          child: const ScoreKeeperApp(),
        ),
      );
    },
        (error, stack) => FirebaseCrashlytics.instance
            .recordError(error, stack, fatal: true));
  } else {
    runApp(
      ProviderScope(
        observers: [Logger()],
        child: const ScoreKeeperApp(),
      ),
    );
  }
}

class ScoreKeeperApp extends ConsumerStatefulWidget {
  const ScoreKeeperApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<ScoreKeeperApp> {
  late final AppRouterDelegate _routerDelegate;
  late final AppRouteInformationParser _routeInformationParser;

  @override
  void initState() {
    _routerDelegate = AppRouterDelegate(ref.read);
    _routeInformationParser = AppRouteInformationParser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLockedServiceConsumer(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ScoreKeeper',
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        // builder: (BuildContext context, _) =>
        //     AppLockedServiceConsumer(child: _),
      ),
    );
  }
}

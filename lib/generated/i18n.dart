// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'messages_all.dart';

class S {
 
  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  static S of(BuildContext context) {
    final localization = Localizations.of<S>(context, S);
    
    assert(() {
      if (localization == null) {
        throw FlutterError(
            'S requested with a context that does not include S.');
      }
      return true;
    }());
    
    return localization!;
  }
  
  static Future<S> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new S();
    });
  }
  
  String get startGame {
    return Intl.message("Start Game", name: 'startGame');
  }

  String get unknown {
    return Intl.message("404!", name: 'unknown');
  }

  String get appName {
    return Intl.message("ScoreKeeper", name: 'appName');
  }

  String get footerAppbarMenu {
    return Intl.message("© 2022 ScoreKeeper", name: 'footerAppbarMenu');
  }

  String get deletePoints {
    return Intl.message("Delete Points?", name: 'deletePoints');
  }

  String get yes {
    return Intl.message("Yes", name: 'yes');
  }

  String get no {
    return Intl.message("No", name: 'no');
  }

  String get changePlayerName {
    return Intl.message("Change Player Name", name: 'changePlayerName');
  }

  String get playerName {
    return Intl.message("Player Name", name: 'playerName');
  }

  String get addPoints {
    return Intl.message("Add Points", name: 'addPoints');
  }

  String get target {
    return Intl.message("Target ", name: 'target');
  }

  String get targetPoints {
    return Intl.message("Target Points", name: 'targetPoints');
  }

  String get changeTargetPoints {
    return Intl.message("Change Target Points", name: 'changeTargetPoints');
  }


}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
			Locale("en", ""),

    ];
  }

  LocaleListResolutionCallback listResolution({Locale? fallback}) {
    return (List<Locale>? locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported);
    };
  }

  Locale _resolve(Locale? locale, Locale? fallback, Iterable<Locale> supported) {
    if (locale == null || !isSupported(locale)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  @override
  Future<S> load(Locale locale) {
    return S.load(locale);
  }

  @override
  bool isSupported(Locale? locale) =>
    locale != null && supportedLocales.contains(locale);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

// ignore_for_file: unnecessary_brace_in_string_interps

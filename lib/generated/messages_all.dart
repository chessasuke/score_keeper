// DO NOT EDIT. This is code generated via package:gen_lang/generate.dart

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

final _$en = $en();

class $en extends MessageLookupByLibrary {
  get localeName => 'en';
  
  final messages = {
		"startGame" : MessageLookupByLibrary.simpleMessage("Start Game"),
		"unknown" : MessageLookupByLibrary.simpleMessage("404!"),
		"appName" : MessageLookupByLibrary.simpleMessage("ScoreKeeper"),
		"footerAppbarMenu" : MessageLookupByLibrary.simpleMessage("© 2022 ScoreKeeper"),
		"deletePoints" : MessageLookupByLibrary.simpleMessage("Delete Points?"),
		"yes" : MessageLookupByLibrary.simpleMessage("Yes"),
		"no" : MessageLookupByLibrary.simpleMessage("No"),
		"changePlayerName" : MessageLookupByLibrary.simpleMessage("Change Player Name"),
		"playerName" : MessageLookupByLibrary.simpleMessage("Player Name"),
		"addPoints" : MessageLookupByLibrary.simpleMessage("Add Points"),
		"target" : MessageLookupByLibrary.simpleMessage("Target "),
		"targetPoints" : MessageLookupByLibrary.simpleMessage("Target Points"),
		"changeTargetPoints" : MessageLookupByLibrary.simpleMessage("Change Target Points"),

  };
}



typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
	"en": () => Future.value(null),

};

MessageLookupByLibrary? _findExact(localeName) {
  switch (localeName) {
    case "en":
        return _$en;

    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName,
          (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());

  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);

  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';

class AppLockedScreenKeys {
  static const String _prefix = "__AppLockedScreenKeys__";
  static ValueKey get mainContainer => const ValueKey("${_prefix}mainContainer");
  static ValueKey get title => const ValueKey("${_prefix}title");
  static ValueKey get description => const ValueKey("${_prefix}description");
}

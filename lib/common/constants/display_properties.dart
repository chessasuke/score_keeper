import 'package:flutter/material.dart';

import 'app_colors.dart';

class DisplayProperties {
  /// Deafult Main Value
  static const double defaultContentPadding = 16.0;
  static const double mainHorizontalPadding = 20.0;
  static const double mainBottomPadding = 48.0;
  static const double mainTopPadding = 24.0;

  static const double defaultBorderRadius = 8.0;

  static const double appbarHeight = 50.0;

  /// Textfields Border
  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    gapPadding: 1,
    borderSide: const BorderSide(color: AppColors.black100),
    borderRadius: BorderRadius.circular(8),
  );
}

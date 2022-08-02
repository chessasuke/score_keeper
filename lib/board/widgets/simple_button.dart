import 'package:flutter/material.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    required this.onTap,
    required this.text,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DisplayProperties.mainHorizontalPadding,
          vertical: DisplayProperties.defaultContentPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DisplayProperties.defaultBorderRadius),
          color: AppColors.black100,
        ),
        child: text,
      ),
    );
  }
}


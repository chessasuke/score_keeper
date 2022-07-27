import 'package:flutter/material.dart';
import 'package:score_keeper/common/constants/app_colors.dart';

class Separator extends StatelessWidget {
  const Separator({
    this.length,
    this.isHorizontal = true,
    this.thickness = 0.33,
    this.color,
    Key? key,
  }) : super(key: key);

  final bool isHorizontal;
  final double? length;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: length == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Container(
                color: AppColors.grayNeutral300,
                height: thickness,
                width: length,
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: length == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Container(
                color: color ?? AppColors.grayNeutral300,
                height: length,
                width: thickness,
              ),
            ],
          );
  }
}

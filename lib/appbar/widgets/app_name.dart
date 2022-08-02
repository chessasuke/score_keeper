import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/asset_path.dart';

class AppName extends StatelessWidget {
  const AppName({
    this.height,
    Key? key,
  }) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'appLogo',
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: SvgPicture.asset(
            AssetPath.appNameSvgBlackLogo,
            fit: BoxFit.contain,
            color: AppColors.black100,
          ),
        ),
        // child: ShaderMask(
        //   shaderCallback: (Rect bounds) => const LinearGradient(
        //     colors: [
        //       AppColors.black100,
        //       Color.fromARGB(0, 152, 142, 109)
        //     ],
        //     tileMode: TileMode.repeated
        //   ).createShader(bounds),
        //   child: SvgPicture.asset(
        //     AssetPath.appNameSvgBlackLogo,
        //     fit: BoxFit.contain,
        //     color: AppColors.black100,
        //   ),
        // ),
      ),
    );
  }
}

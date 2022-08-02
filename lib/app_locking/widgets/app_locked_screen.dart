import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:score_keeper/app_locking/model/app_locked_state.dart';
import 'package:score_keeper/app_locking/widgets/app_locked_screen_keys.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/asset_path.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/text_style.dart';

class AppLockedScreen extends StatefulWidget {
  const AppLockedScreen({
    required this.appLockedState,
    Key? key,
  }) : super(key: key);

  final AppLockedState appLockedState;

  @override
  AppLockedScreenState createState() => AppLockedScreenState();
}

class AppLockedScreenState extends State<AppLockedScreen> {

  late final String title;
  late final String message;

  @override
  void initState() {
    super.initState();
    title = widget.appLockedState.getTitle();
    message = widget.appLockedState.getDescription();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: UnclosableMessageScreen(
            title: Text(
              title,
              style: TextStyles.display02.copyWith(color: AppColors.white100),
              key: AppLockedScreenKeys.title,
            ),
            description: RichText(
              text: TextSpan(
                text: message,
                style: TextStyles.body01.copyWith(color: AppColors.white100),
              ),
              key: AppLockedScreenKeys.description,
            ),
            titleDescriptionPadding: 16,
            mainContainerKey: AppLockedScreenKeys.mainContainer,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class UnclosableMessageScreen extends StatelessWidget {
  const UnclosableMessageScreen({
    required this.title,
    required this.description,
    required this.mainContainerKey,
    this.titleDescriptionPadding = 24,
    this.child,
    this.footer,
    this.backgroundColor = AppColors.black100,
    Key? key,
  }) : super(key: key);

  final Widget title;
  final Widget description;
  final Key mainContainerKey;
  final double titleDescriptionPadding;
  final Widget? child;
  final Widget? footer;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        key: mainContainerKey,
        padding: const EdgeInsets.symmetric(
            horizontal: DisplayProperties.defaultContentPadding),
        color: backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Header(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: DisplayProperties.defaultContentPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        SizedBox(
                          height: titleDescriptionPadding,
                        ),
                        description,
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (child != null) child!,
                  footer ?? const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: DisplayProperties.mainTopPadding),
      child: SvgPicture.asset(AssetPath.appNameSvgBlackLogo),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/game_state.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/button_with_input_dialog.dart';
import 'package:score_keeper/board/widgets/simple_button.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/font_weights.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/generated/i18n.dart';
import 'package:score_keeper/screens/game_board.dart';

class TargetPoints extends ConsumerWidget {
  const TargetPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int gameTargetPoints = ref.watch(
        gameStateProvider.select((GameState value) => value.targetPoints));

    ref.listen<String?>(
      gameStateProvider.select((value) => value.winnerId),
      (previous, next) {
        if (previous == null && next != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showWinnerDialog(context, next);
          });
        }
      },
    );

    return ButtonWithInputDialog(
      onTap: () => _onPressed(context, ref),
      onChangedInput: (value) => _onChangedInput(value, ref),
      labelText: S.of(context).targetPoints,
      dialogBtnText: S.of(context).changeTargetPoints,
      initialValue: gameTargetPoints.toString(),
      child: _TargetPointsText(gameTargetPoints: '$gameTargetPoints'),
    );
  }

  void _onPressed(BuildContext context, WidgetRef ref) {
    final newTargetPoints = int.tryParse(ref.read(addPointsTextFieldProvider));
    if (newTargetPoints != null) {
      ref
          .read(gameStateProvider.notifier)
          .editGame(targetPoints: newTargetPoints);
    }
    Navigator.pop(context);
  }

  void _onChangedInput(String value, WidgetRef ref) =>
      ref.read(addPointsTextFieldProvider.notifier).state = value;

  void _showWinnerDialog(BuildContext context, String playerId) {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => showDialog(
            context: context,
            builder: (context) => _WinnerDialog(playerId: playerId)));
  }
}

class _TargetPointsText extends StatelessWidget {
  const _TargetPointsText({
    required this.gameTargetPoints,
    Key? key,
  }) : super(key: key);

  final String gameTargetPoints;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: S.of(context).target,
        style: TextStyles.heading02,
        children: [
          TextSpan(
            text: gameTargetPoints,
            style: TextStyles.underlinedTextButtonTextStyle.copyWith(
              fontWeight: FontWeights.light,
            ),
          ),
        ],
      ),
    );
  }
}

class _WinnerDialog extends ConsumerWidget {
  const _WinnerDialog({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(DisplayProperties.defaultContentPadding),
          child:
              Text('Congrats ${getPlayerName(ref) ?? 'Player $playerId'} Won!'),
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SimpleButton(
              onTap: () => _onReset(ref, context),
              text: Text(
                'Reset',
                style: TextStyles.heading03.copyWith(color: AppColors.white100),
              ),
            ),
            SimpleButton(
              onTap: () => _close(ref, context),
              text: Text(
                'Close',
                style: TextStyles.heading03.copyWith(color: AppColors.white100),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _close(WidgetRef ref, BuildContext context) {
    Navigator.pop(context);
  }

  void _onReset(WidgetRef ref, BuildContext context) {
    ref.refresh(gameStateProvider);
    Navigator.pop(context);
  }

  String? getPlayerName(WidgetRef ref) =>
      ref.read(gameStateProvider.notifier).getPlayerName(playerId);
}

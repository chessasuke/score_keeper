import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/appbar/widgets/app_name.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/simple_button.dart';
import 'package:score_keeper/common/constants/display_properties.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/common/utils/utils.dart';
import 'package:score_keeper/common/widgets/basic_text_field.dart';
import 'package:score_keeper/generated/i18n.dart';
import 'package:score_keeper/navigator/page_manager.dart';
import 'package:score_keeper/common/constants/app_colors.dart';
import 'package:score_keeper/navigator/route_utils.dart';
import 'package:score_keeper/services/analytics/events/actions_events.dart';
import 'package:score_keeper/services/analytics/models/event.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white100,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const AppName(),
              Column(
                children: [
                  const _SetTargetPoints(),
                  const SizedBox(
                      height: DisplayProperties.defaultContentPadding),
                  const _SetNumberOfPlayers(),
                  const SizedBox(
                      height: DisplayProperties.defaultContentPadding),
                  SimpleButton(
                    onTap: () => _startNewGame(ref),
                    text: Text(
                      S.of(context).startGame,
                      style: TextStyles.heading03
                          .copyWith(color: AppColors.white100),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startNewGame(WidgetRef ref) {
    Utils.trackEvent(
      event: Event(name: ActionsEvents.startGame.name),
      ref: ref,
    );
    ref.read(pageManagerProvider).addPage(RoutePath.gameBoard);
  }
}

class _SetTargetPoints extends ConsumerWidget {
  const _SetTargetPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicTextField(
      width: 150,
      textInputType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: 'Target Points',
      onChange: (value) => _onChange(ref, value),
      initialValue: ref.read(targetPointsProvider).toString(),
      style: TextStyles.heading02,
    );
  }

  void _onChange(WidgetRef ref, String value) {
    final newValue = int.tryParse(value);
    if (newValue != null) {
      ref.read(targetPointsProvider.notifier).state = newValue;
    }
  }
}

class _SetNumberOfPlayers extends ConsumerWidget {
  const _SetNumberOfPlayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicTextField(
      width: 150,
      textInputType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      labelText: 'Number of Players',
      onChange: (value) => _onChange(ref, value),
      initialValue: ref.read(numPlayersProvider).toString(),
      style: TextStyles.heading02,
    );
  }

  void _onChange(WidgetRef ref, String value) {
    final newValue = int.tryParse(value);
    if (newValue != null) {
      ref.read(numPlayersProvider.notifier).state = newValue;
    }
  }
}

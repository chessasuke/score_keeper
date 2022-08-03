import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/button_with_input_dialog.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/generated/i18n.dart';

class PlayerName extends ConsumerWidget {
  const PlayerName({
    required this.playerIndex,
    Key? key,
  }) : super(key: key);

  final int playerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(
      gameStateProvider.select(
        (value) => value.players[playerIndex].name,
      ),
    );
    return ButtonWithInputDialog(
      onTap: () => _onPressed(context, ref, playerIndex),
      onChangedInput: (value) => _onChangedInput(value, ref),
      dialogBtnText: S.of(context).changePlayerName,
      labelText: S.of(context).playerName,
      initialValue: name,
      child: AutoSizeText(
        name,
        style: TextStyles.heading02,
        maxLines: 1,
      ),
    );
  }

  void _onPressed(BuildContext context, WidgetRef ref, int playerIndex) {
    final newName = ref.read(gameNameTextfieldProvider);
    if (newName.isNotEmpty) {
      final player = ref.watch(
        gameStateProvider.select(
          (value) => value.players[playerIndex],
        ),
      );
      final newPlayer = player.copyWith(name: newName);
      ref.read(gameStateProvider.notifier).editPlayer(newPlayer);
    }
    Navigator.pop(context);
  }

  void _onChangedInput(String value, WidgetRef ref) =>
      ref.read(gameNameTextfieldProvider.notifier).state = value;
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/button_with_input_dialog.dart';
import 'package:score_keeper/generated/i18n.dart';

class AddPointsBtn extends ConsumerWidget {
  const AddPointsBtn({
    required this.playerIndex,
    Key? key,
  }) : super(key: key);

  final int playerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialValue = ref.watch(addPointsTextfieldProvider);

    return ButtonWithInputDialog(
      initialValue: initialValue.toString(),
      onTap: () => _addPoints(context, ref),
      onLongPress: () => _increment(context, ref),
      onChangedInput: (value) => _onChangedInput(ref, value),
      dialogBtnText: S.of(context).addPoints,
      child: const Icon(Icons.add),
    );
  }

  void _onChangedInput(WidgetRef ref, String value) {
    final pointsToAdd = int.tryParse(value);
    if (pointsToAdd != null) {
      ref.read(addPointsTextfieldProvider.notifier).state = pointsToAdd;
    }
  }

  void _addPoints(BuildContext context, WidgetRef ref) {
    final pointsToAdd = ref.read(addPointsTextfieldProvider);
    if (pointsToAdd != 0) {
      _addPointsAndReset(ref, pointsToAdd);
    }
    Navigator.pop(context);
  }

  void _increment(BuildContext context, WidgetRef ref) {
    _addPointsAndReset(ref, 1);
  }

  void _addPointsAndReset(WidgetRef ref, int pointsToAdd) {
    final playerId =
        ref.read(gameStateProvider.notifier).getPlayerIdByIndex(playerIndex);

    ref.read(gameStateProvider.notifier).addPlayerPoints(
          playerId: playerId,
          pointsToAdd: pointsToAdd,
        );

    /// reset to 1
    ref.read(addPointsTextfieldProvider.notifier).state = 1;
  }
}

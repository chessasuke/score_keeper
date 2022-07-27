import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/point.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/button_with_input_dialog.dart';
import 'package:score_keeper/board/widgets/dragable_point.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/common/widgets/separator.dart';
import 'package:score_keeper/generated/i18n.dart';

class PlayerBoard extends ConsumerWidget {
  const PlayerBoard({
    required this.playerIndex,
    required this.screenSize,
    Key? key,
  }) : super(key: key);

  final int playerIndex;
  final Size screenSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SizedBox(
      width: screenSize.width / 2 - 1,
      child: DragTarget<Point>(
        onAccept: (Point point) => _onAccept(ref, point, playerIndex),
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Column(
            children: [
              Column(
                children: [
                  _PlayerName(playerIndex: playerIndex),
                  _PlayerPoints(playerIndex: playerIndex),
                ],
              ),
              Separator(thickness: 0.5, length: (screenSize.width / 2) * 0.8),
              _PlayerPointsHistory(playerIndex: playerIndex),
              const Spacer(),
              ButtonWithInputDialog(
                onPressed: () => _addPoints(context, ref),
                onChangedInput: (value) => _onChangedInput(ref, value),
                dialogBtnText: S.of(context).addPoints,
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onAccept(WidgetRef ref, Point point, int playerIndex) {
    final currentPointOwnerPlayerId = point.currentPointOwnerPlayerId;
    final newPointOwnerPlayerId =
        ref.read(gameStateProvider.notifier).getPlayerIdByIndex(playerIndex);

    if (currentPointOwnerPlayerId != newPointOwnerPlayerId) {
      ref.read(gameStateProvider.notifier).removePlayerPoints(
            playerId: currentPointOwnerPlayerId,
            pointsToRemove: point.point,
          );

      ref.read(gameStateProvider.notifier).addPlayerPoints(
            playerId: newPointOwnerPlayerId,
            pointsToAdd: point.point,
          );
    }
  }

  void _addPoints(BuildContext context, WidgetRef ref) {
    final pointsToAdd = ref.read(addPointsTextfieldProvider);
    final playerId =
        ref.read(gameStateProvider.notifier).getPlayerIdByIndex(playerIndex);

    if (pointsToAdd != 0) {
      ref.read(gameStateProvider.notifier).addPlayerPoints(
            playerId: playerId,
            pointsToAdd: pointsToAdd,
          );
    }
    Navigator.pop(context);
  }

  void _onChangedInput(WidgetRef ref, String value) {
    final pointsToAdd = int.tryParse(value);
    if (pointsToAdd != null) {
      ref.read(addPointsTextfieldProvider.notifier).state = pointsToAdd;
    }
  }
}

class _PlayerName extends ConsumerWidget {
  const _PlayerName({
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
      onPressed: () => _onPressed(context, ref, playerIndex),
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

class _PlayerPoints extends ConsumerWidget {
  const _PlayerPoints({
    required this.playerIndex,
    Key? key,
  }) : super(key: key);

  final int playerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(gameStateProvider.select((value) {
      return value.players[playerIndex].currentPoints;
    }));
    return AutoSizeText(
      '$points',
      style: TextStyles.heading02,
      maxLines: 1,
    );
  }
}

class _PlayerPointsHistory extends ConsumerWidget {
  const _PlayerPointsHistory({
    required this.playerIndex,
    Key? key,
  }) : super(key: key);

  final int playerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref
        .watch(gameStateProvider.select((value) => value.players[playerIndex]));

    return Column(
      children: [
        ...player.pointHistory
            .map(
              (point) => DraggablePoint(
                point: Point(
                  point: point,
                  currentPointOwnerPlayerId: player.id,
                ),
                removePoints: (int points) => _onRemovePoints(
                  ref,
                  points,
                  player.id,
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  void _onRemovePoints(WidgetRef ref, int value, String playerId) {
    if (value != 0) {
      ref.read(gameStateProvider.notifier).removePlayerPoints(
            playerId: playerId,
            pointsToRemove: value,
          );
    }
  }
}

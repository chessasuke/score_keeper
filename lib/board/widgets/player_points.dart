


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/point.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/dragable_point.dart';
import 'package:score_keeper/common/text/text_style.dart';
import 'package:score_keeper/common/widgets/animated_count.dart';

class PlayerPoints extends ConsumerWidget {
  const PlayerPoints({
    required this.playerIndex,
    Key? key,
  }) : super(key: key);

  final int playerIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(gameStateProvider.select((value) {
      return value.players[playerIndex].currentPoints;
    }));
    return AnimatedCount(
      count: points,
      style: TextStyles.heading02,
    );
  }
}

class PlayerPointsHistory extends ConsumerWidget {
  const PlayerPointsHistory({
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

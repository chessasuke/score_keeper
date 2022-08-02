import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/point.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/board/widgets/add_points_btn.dart';
import 'package:score_keeper/board/widgets/player_name.dart';
import 'package:score_keeper/board/widgets/player_points.dart';
import 'package:score_keeper/common/widgets/separator.dart';

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
                  PlayerName(playerIndex: playerIndex),
                  PlayerPoints(playerIndex: playerIndex),
                ],
              ),
              Separator(thickness: 0.5, length: (screenSize.width / 2) * 0.8),
              PlayerPointsHistory(playerIndex: playerIndex),
              const Spacer(),
              AddPointsBtn(playerIndex: playerIndex),
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
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/game_state.dart';
import 'package:score_keeper/board/model/player.dart';
import 'package:score_keeper/common/utils/utils.dart';

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier({
    GameState? game,
    int numPlayers = 2,
    int targetPoints = 100,
  }) : super(
          game ??
              GameState.initial(
                numPlayers: numPlayers,
                targetPoints: targetPoints,
              ),
        );

  String getPlayerIdByIndex(int index) {
    return state.players[index].id;
  }

  Player getPlayerByIndex(int index) {
    return state.players[index];
  }

  int? getPlayerTotal(String playerId) {
    final player = _getPlayer(playerId);
    return player.pointHistory.reduce((value, element) => value + element);
  }

  String? getPlayerName(String playerId) {
    final player = _getPlayer(playerId);
    return player.name;
  }

  void editGame({
    String? id,
    String? name,
    List<Player>? players,
    int? targetPoints,
    String? winnerId,
  }) {
    state = state.copyWith(
      id: id ?? state.id,
      name: name ?? state.name,
      players: players ?? state.players,
      targetPoints: targetPoints ?? state.targetPoints,
      winnerId: winnerId ?? state.winnerId,
    );
  }

  addPlayerPoints({required String playerId, required int pointsToAdd}) {
    final playerToUpdate = _getPlayer(playerId);
    final newPlayerPointsHistory = [
      ...playerToUpdate.pointHistory,
      pointsToAdd
    ];
    final newTotalPoints = Utils.calculatePlayerPoints(newPlayerPointsHistory);

    final updatedPlayer = playerToUpdate.copyWith(
      pointHistory: newPlayerPointsHistory,
      currentPoints: newTotalPoints,
    );
    editPlayer(updatedPlayer);
  }

  removePlayerPoints({required String playerId, required int pointsToRemove}) {
    final playerToUpdate = _getPlayer(playerId);

    final newPlayerPointsHistory = playerToUpdate.pointHistory;
    newPlayerPointsHistory.remove(pointsToRemove);
    final newTotalPoints = Utils.calculatePlayerPoints(newPlayerPointsHistory);

    final updatedPlayer = playerToUpdate.copyWith(
      pointHistory: newPlayerPointsHistory,
      currentPoints: newTotalPoints,
    );
    editPlayer(updatedPlayer);
  }

  void editPlayer(Player udpatedPlayer) {
    if (state.winnerId == null && udpatedPlayer.currentPoints >= state.targetPoints) {
      state = state.copyWith(
        winnerId: udpatedPlayer.id,
        players: [
          for (final Player player in state.players)
            if (player.id == udpatedPlayer.id) udpatedPlayer else player
        ],
      );
    } else {
      state = state.copyWith(
        players: [
          for (final Player player in state.players)
            if (player.id == udpatedPlayer.id) udpatedPlayer else player
        ],
      );
    }
  }

  Player _getPlayer(String playerId) =>
      state.players.firstWhere((Player player) => player.id == playerId);
}

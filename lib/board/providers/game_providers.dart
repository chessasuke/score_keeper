import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/model/game_state.dart';
import 'package:score_keeper/board/providers/game_state_notifier.dart';

final numPlayersProvider = StateProvider((ref) => 2);

final targetPointsProvider = StateProvider((ref) => 100);

final gameNameTextfieldProvider = StateProvider((ref) {
  final initialValue = ref.read(gameStateProvider).name;
  return initialValue;
});

final addPointsTextfieldProvider = StateProvider((ref) => 1);

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  final numPlayers =  ref.watch(numPlayersProvider);
    final targetPoints =  ref.watch(targetPointsProvider);
  return GameStateNotifier(numPlayers: numPlayers, targetPoints: targetPoints);
});
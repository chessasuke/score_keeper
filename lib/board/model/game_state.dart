import 'package:equatable/equatable.dart';
import 'package:score_keeper/board/model/player.dart';
import 'package:uuid/uuid.dart';

class GameState extends Equatable {
  const GameState({
    required this.id,
    required this.players,
    required this.targetPoints,
    this.name = 'New Game',
    this.winnerId,
  });

  final String id;
  final String name;
  final List<Player> players;
  final int targetPoints;
  final String? winnerId;

  factory GameState.initial({
    required int numPlayers,
    required int targetPoints,
  }) =>
      GameState(
        id: const Uuid().v4(),
        players: List<Player>.generate(
          numPlayers,
          (index) => Player(
            id: index.toString(),
            name: 'Player $index',
          ),
        ),
        targetPoints: targetPoints,
        winnerId: null,
      );

  GameState copyWith({
    String? id,
    String? name,
    List<Player>? players,
    int? targetPoints,
    String? winnerId,
  }) =>
      GameState(
        id: id ?? this.id,
        name: name ?? this.name,
        players: players ?? this.players,
        targetPoints: targetPoints ?? this.targetPoints,
        winnerId: winnerId ?? this.winnerId,
      );

  @override
  List<Object?> get props => [id, name, players, targetPoints, winnerId];
}

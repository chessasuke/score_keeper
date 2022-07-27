import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.id,
    required this.name,
    this.currentPoints = 0,
    this.pointHistory = const [],
  });

  final String id;
  final String name;
  final int currentPoints;
  final List<int> pointHistory;

  Player copyWith({
    String? id,
    String? name,
    int? currentPoints,
    List<int>? pointHistory,
  }) =>
      Player(
        id: id ?? this.id,
        name: name ?? this.name,
        currentPoints: currentPoints ?? this.currentPoints,
        pointHistory: pointHistory ?? this.pointHistory,
      );

  @override
  List<Object?> get props => [id, name, currentPoints, pointHistory];
}

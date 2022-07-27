import 'package:equatable/equatable.dart';

class Point extends Equatable {
  const Point({
    required this.currentPointOwnerPlayerId,
    required this.point,
  });

  final String currentPointOwnerPlayerId;
  final int point;

  @override
  List<Object?> get props => [point, currentPointOwnerPlayerId];
}

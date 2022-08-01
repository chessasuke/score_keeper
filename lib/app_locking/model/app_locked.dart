import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_locked.g.dart';

@JsonSerializable()
class AppLocked extends Equatable {
  const AppLocked({
    required this.isDown,
    required this.android,
    required this.ios,
  });

  final bool isDown;
  final int android;
  final int ios;

  factory AppLocked.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => AppLocked.fromJson(snapshot.data()!);
  

  factory AppLocked.fromJson(Map<String, dynamic> json) =>
      _$AppLockedFromJson(json);

  Map<String, Object?> toJson() => _$AppLockedToJson(this);

  @override
  List<Object?> get props => [isDown, android, ios];
}

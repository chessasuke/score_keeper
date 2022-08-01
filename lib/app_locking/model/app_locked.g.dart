// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locked.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppLocked _$AppLockedFromJson(Map<String, dynamic> json) => AppLocked(
      isDown: json['isDown'] as bool,
      android: json['android'] as int,
      ios: json['ios'] as int,
    );

Map<String, dynamic> _$AppLockedToJson(AppLocked instance) => <String, dynamic>{
      'isDown': instance.isDown,
      'android': instance.android,
      'ios': instance.ios,
    };

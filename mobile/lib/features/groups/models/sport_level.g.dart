// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SportLevelImpl _$$SportLevelImplFromJson(Map<String, dynamic> json) =>
    _$SportLevelImpl(
      levelKey: json['level_key'] as String,
      levelName: json['level_name'] as String,
      sportType: json['sport_type'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$SportLevelImplToJson(_$SportLevelImpl instance) =>
    <String, dynamic>{
      'level_key': instance.levelKey,
      'level_name': instance.levelName,
      'sport_type': instance.sportType,
      'description': instance.description,
    };

_$SportLevelsResponseImpl _$$SportLevelsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SportLevelsResponseImpl(
      success: json['success'] as bool,
      data: SportLevelsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SportLevelsResponseImplToJson(
        _$SportLevelsResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

_$SportLevelsDataImpl _$$SportLevelsDataImplFromJson(
        Map<String, dynamic> json) =>
    _$SportLevelsDataImpl(
      sportType: json['sport_type'] as String,
      levels: (json['levels'] as List<dynamic>)
          .map((e) => SportLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SportLevelsDataImplToJson(
        _$SportLevelsDataImpl instance) =>
    <String, dynamic>{
      'sport_type': instance.sportType,
      'levels': instance.levels,
    };

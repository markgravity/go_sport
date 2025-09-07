import 'package:freezed_annotation/freezed_annotation.dart';

part 'sport_level.freezed.dart';
part 'sport_level.g.dart';

/// Model for sport skill level requirements
@freezed
class SportLevel with _$SportLevel {
  const factory SportLevel({
    required String levelKey,
    required String levelName,
    required String sportType,
    String? description,
  }) = _SportLevel;

  factory SportLevel.fromJson(Map<String, dynamic> json) => _$SportLevelFromJson(json);
}

/// Response model for sport levels API
@freezed
class SportLevelsResponse with _$SportLevelsResponse {
  const factory SportLevelsResponse({
    required bool success,
    required SportLevelsData data,
  }) = _SportLevelsResponse;

  factory SportLevelsResponse.fromJson(Map<String, dynamic> json) => _$SportLevelsResponseFromJson(json);
}

@freezed
class SportLevelsData with _$SportLevelsData {
  const factory SportLevelsData({
    required String sportType,
    required List<SportLevel> levels,
  }) = _SportLevelsData;

  factory SportLevelsData.fromJson(Map<String, dynamic> json) => _$SportLevelsDataFromJson(json);
}
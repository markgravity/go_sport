// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sport_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SportLevel _$SportLevelFromJson(Map<String, dynamic> json) {
  return _SportLevel.fromJson(json);
}

/// @nodoc
mixin _$SportLevel {
  String get levelKey => throw _privateConstructorUsedError;
  String get levelName => throw _privateConstructorUsedError;
  String get sportType => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this SportLevel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SportLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SportLevelCopyWith<SportLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SportLevelCopyWith<$Res> {
  factory $SportLevelCopyWith(
          SportLevel value, $Res Function(SportLevel) then) =
      _$SportLevelCopyWithImpl<$Res, SportLevel>;
  @useResult
  $Res call(
      {String levelKey,
      String levelName,
      String sportType,
      String? description});
}

/// @nodoc
class _$SportLevelCopyWithImpl<$Res, $Val extends SportLevel>
    implements $SportLevelCopyWith<$Res> {
  _$SportLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SportLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levelKey = null,
    Object? levelName = null,
    Object? sportType = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      levelKey: null == levelKey
          ? _value.levelKey
          : levelKey // ignore: cast_nullable_to_non_nullable
              as String,
      levelName: null == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SportLevelImplCopyWith<$Res>
    implements $SportLevelCopyWith<$Res> {
  factory _$$SportLevelImplCopyWith(
          _$SportLevelImpl value, $Res Function(_$SportLevelImpl) then) =
      __$$SportLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String levelKey,
      String levelName,
      String sportType,
      String? description});
}

/// @nodoc
class __$$SportLevelImplCopyWithImpl<$Res>
    extends _$SportLevelCopyWithImpl<$Res, _$SportLevelImpl>
    implements _$$SportLevelImplCopyWith<$Res> {
  __$$SportLevelImplCopyWithImpl(
      _$SportLevelImpl _value, $Res Function(_$SportLevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SportLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? levelKey = null,
    Object? levelName = null,
    Object? sportType = null,
    Object? description = freezed,
  }) {
    return _then(_$SportLevelImpl(
      levelKey: null == levelKey
          ? _value.levelKey
          : levelKey // ignore: cast_nullable_to_non_nullable
              as String,
      levelName: null == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String,
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SportLevelImpl implements _SportLevel {
  const _$SportLevelImpl(
      {required this.levelKey,
      required this.levelName,
      required this.sportType,
      this.description});

  factory _$SportLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SportLevelImplFromJson(json);

  @override
  final String levelKey;
  @override
  final String levelName;
  @override
  final String sportType;
  @override
  final String? description;

  @override
  String toString() {
    return 'SportLevel(levelKey: $levelKey, levelName: $levelName, sportType: $sportType, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SportLevelImpl &&
            (identical(other.levelKey, levelKey) ||
                other.levelKey == levelKey) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName) &&
            (identical(other.sportType, sportType) ||
                other.sportType == sportType) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, levelKey, levelName, sportType, description);

  /// Create a copy of SportLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SportLevelImplCopyWith<_$SportLevelImpl> get copyWith =>
      __$$SportLevelImplCopyWithImpl<_$SportLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SportLevelImplToJson(
      this,
    );
  }
}

abstract class _SportLevel implements SportLevel {
  const factory _SportLevel(
      {required final String levelKey,
      required final String levelName,
      required final String sportType,
      final String? description}) = _$SportLevelImpl;

  factory _SportLevel.fromJson(Map<String, dynamic> json) =
      _$SportLevelImpl.fromJson;

  @override
  String get levelKey;
  @override
  String get levelName;
  @override
  String get sportType;
  @override
  String? get description;

  /// Create a copy of SportLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SportLevelImplCopyWith<_$SportLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SportLevelsResponse _$SportLevelsResponseFromJson(Map<String, dynamic> json) {
  return _SportLevelsResponse.fromJson(json);
}

/// @nodoc
mixin _$SportLevelsResponse {
  bool get success => throw _privateConstructorUsedError;
  SportLevelsData get data => throw _privateConstructorUsedError;

  /// Serializes this SportLevelsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SportLevelsResponseCopyWith<SportLevelsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SportLevelsResponseCopyWith<$Res> {
  factory $SportLevelsResponseCopyWith(
          SportLevelsResponse value, $Res Function(SportLevelsResponse) then) =
      _$SportLevelsResponseCopyWithImpl<$Res, SportLevelsResponse>;
  @useResult
  $Res call({bool success, SportLevelsData data});

  $SportLevelsDataCopyWith<$Res> get data;
}

/// @nodoc
class _$SportLevelsResponseCopyWithImpl<$Res, $Val extends SportLevelsResponse>
    implements $SportLevelsResponseCopyWith<$Res> {
  _$SportLevelsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SportLevelsData,
    ) as $Val);
  }

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SportLevelsDataCopyWith<$Res> get data {
    return $SportLevelsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SportLevelsResponseImplCopyWith<$Res>
    implements $SportLevelsResponseCopyWith<$Res> {
  factory _$$SportLevelsResponseImplCopyWith(_$SportLevelsResponseImpl value,
          $Res Function(_$SportLevelsResponseImpl) then) =
      __$$SportLevelsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, SportLevelsData data});

  @override
  $SportLevelsDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$SportLevelsResponseImplCopyWithImpl<$Res>
    extends _$SportLevelsResponseCopyWithImpl<$Res, _$SportLevelsResponseImpl>
    implements _$$SportLevelsResponseImplCopyWith<$Res> {
  __$$SportLevelsResponseImplCopyWithImpl(_$SportLevelsResponseImpl _value,
      $Res Function(_$SportLevelsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? data = null,
  }) {
    return _then(_$SportLevelsResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SportLevelsData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SportLevelsResponseImpl implements _SportLevelsResponse {
  const _$SportLevelsResponseImpl({required this.success, required this.data});

  factory _$SportLevelsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SportLevelsResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final SportLevelsData data;

  @override
  String toString() {
    return 'SportLevelsResponse(success: $success, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SportLevelsResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, data);

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SportLevelsResponseImplCopyWith<_$SportLevelsResponseImpl> get copyWith =>
      __$$SportLevelsResponseImplCopyWithImpl<_$SportLevelsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SportLevelsResponseImplToJson(
      this,
    );
  }
}

abstract class _SportLevelsResponse implements SportLevelsResponse {
  const factory _SportLevelsResponse(
      {required final bool success,
      required final SportLevelsData data}) = _$SportLevelsResponseImpl;

  factory _SportLevelsResponse.fromJson(Map<String, dynamic> json) =
      _$SportLevelsResponseImpl.fromJson;

  @override
  bool get success;
  @override
  SportLevelsData get data;

  /// Create a copy of SportLevelsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SportLevelsResponseImplCopyWith<_$SportLevelsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SportLevelsData _$SportLevelsDataFromJson(Map<String, dynamic> json) {
  return _SportLevelsData.fromJson(json);
}

/// @nodoc
mixin _$SportLevelsData {
  String get sportType => throw _privateConstructorUsedError;
  List<SportLevel> get levels => throw _privateConstructorUsedError;

  /// Serializes this SportLevelsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SportLevelsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SportLevelsDataCopyWith<SportLevelsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SportLevelsDataCopyWith<$Res> {
  factory $SportLevelsDataCopyWith(
          SportLevelsData value, $Res Function(SportLevelsData) then) =
      _$SportLevelsDataCopyWithImpl<$Res, SportLevelsData>;
  @useResult
  $Res call({String sportType, List<SportLevel> levels});
}

/// @nodoc
class _$SportLevelsDataCopyWithImpl<$Res, $Val extends SportLevelsData>
    implements $SportLevelsDataCopyWith<$Res> {
  _$SportLevelsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SportLevelsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sportType = null,
    Object? levels = null,
  }) {
    return _then(_value.copyWith(
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as String,
      levels: null == levels
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<SportLevel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SportLevelsDataImplCopyWith<$Res>
    implements $SportLevelsDataCopyWith<$Res> {
  factory _$$SportLevelsDataImplCopyWith(_$SportLevelsDataImpl value,
          $Res Function(_$SportLevelsDataImpl) then) =
      __$$SportLevelsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sportType, List<SportLevel> levels});
}

/// @nodoc
class __$$SportLevelsDataImplCopyWithImpl<$Res>
    extends _$SportLevelsDataCopyWithImpl<$Res, _$SportLevelsDataImpl>
    implements _$$SportLevelsDataImplCopyWith<$Res> {
  __$$SportLevelsDataImplCopyWithImpl(
      _$SportLevelsDataImpl _value, $Res Function(_$SportLevelsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SportLevelsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sportType = null,
    Object? levels = null,
  }) {
    return _then(_$SportLevelsDataImpl(
      sportType: null == sportType
          ? _value.sportType
          : sportType // ignore: cast_nullable_to_non_nullable
              as String,
      levels: null == levels
          ? _value._levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<SportLevel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SportLevelsDataImpl implements _SportLevelsData {
  const _$SportLevelsDataImpl(
      {required this.sportType, required final List<SportLevel> levels})
      : _levels = levels;

  factory _$SportLevelsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SportLevelsDataImplFromJson(json);

  @override
  final String sportType;
  final List<SportLevel> _levels;
  @override
  List<SportLevel> get levels {
    if (_levels is EqualUnmodifiableListView) return _levels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_levels);
  }

  @override
  String toString() {
    return 'SportLevelsData(sportType: $sportType, levels: $levels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SportLevelsDataImpl &&
            (identical(other.sportType, sportType) ||
                other.sportType == sportType) &&
            const DeepCollectionEquality().equals(other._levels, _levels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sportType, const DeepCollectionEquality().hash(_levels));

  /// Create a copy of SportLevelsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SportLevelsDataImplCopyWith<_$SportLevelsDataImpl> get copyWith =>
      __$$SportLevelsDataImplCopyWithImpl<_$SportLevelsDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SportLevelsDataImplToJson(
      this,
    );
  }
}

abstract class _SportLevelsData implements SportLevelsData {
  const factory _SportLevelsData(
      {required final String sportType,
      required final List<SportLevel> levels}) = _$SportLevelsDataImpl;

  factory _SportLevelsData.fromJson(Map<String, dynamic> json) =
      _$SportLevelsDataImpl.fromJson;

  @override
  String get sportType;
  @override
  List<SportLevel> get levels;

  /// Create a copy of SportLevelsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SportLevelsDataImplCopyWith<_$SportLevelsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

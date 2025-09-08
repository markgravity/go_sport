// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InvitationAnalytics _$InvitationAnalyticsFromJson(Map<String, dynamic> json) {
  return _InvitationAnalytics.fromJson(json);
}

/// @nodoc
mixin _$InvitationAnalytics {
  int get invitationId => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  String? get userAgent => throw _privateConstructorUsedError;
  String? get ipAddress => throw _privateConstructorUsedError;
  String? get referrer => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationAnalytics value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationAnalytics value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationAnalytics value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationAnalyticsCopyWith<InvitationAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationAnalyticsCopyWith<$Res> {
  factory $InvitationAnalyticsCopyWith(
          InvitationAnalytics value, $Res Function(InvitationAnalytics) then) =
      _$InvitationAnalyticsCopyWithImpl<$Res, InvitationAnalytics>;
  @useResult
  $Res call(
      {int invitationId,
      String eventType,
      String? userAgent,
      String? ipAddress,
      String? referrer,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class _$InvitationAnalyticsCopyWithImpl<$Res, $Val extends InvitationAnalytics>
    implements $InvitationAnalyticsCopyWith<$Res> {
  _$InvitationAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitationId = null,
    Object? eventType = null,
    Object? userAgent = freezed,
    Object? ipAddress = freezed,
    Object? referrer = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      invitationId: null == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referrer: freezed == referrer
          ? _value.referrer
          : referrer // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationAnalyticsImplCopyWith<$Res>
    implements $InvitationAnalyticsCopyWith<$Res> {
  factory _$$InvitationAnalyticsImplCopyWith(_$InvitationAnalyticsImpl value,
          $Res Function(_$InvitationAnalyticsImpl) then) =
      __$$InvitationAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int invitationId,
      String eventType,
      String? userAgent,
      String? ipAddress,
      String? referrer,
      Map<String, dynamic>? metadata,
      DateTime createdAt});
}

/// @nodoc
class __$$InvitationAnalyticsImplCopyWithImpl<$Res>
    extends _$InvitationAnalyticsCopyWithImpl<$Res, _$InvitationAnalyticsImpl>
    implements _$$InvitationAnalyticsImplCopyWith<$Res> {
  __$$InvitationAnalyticsImplCopyWithImpl(_$InvitationAnalyticsImpl _value,
      $Res Function(_$InvitationAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitationId = null,
    Object? eventType = null,
    Object? userAgent = freezed,
    Object? ipAddress = freezed,
    Object? referrer = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$InvitationAnalyticsImpl(
      invitationId: null == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referrer: freezed == referrer
          ? _value.referrer
          : referrer // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationAnalyticsImpl implements _InvitationAnalytics {
  const _$InvitationAnalyticsImpl(
      {required this.invitationId,
      required this.eventType,
      this.userAgent,
      this.ipAddress,
      this.referrer,
      final Map<String, dynamic>? metadata,
      required this.createdAt})
      : _metadata = metadata;

  factory _$InvitationAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationAnalyticsImplFromJson(json);

  @override
  final int invitationId;
  @override
  final String eventType;
  @override
  final String? userAgent;
  @override
  final String? ipAddress;
  @override
  final String? referrer;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'InvitationAnalytics(invitationId: $invitationId, eventType: $eventType, userAgent: $userAgent, ipAddress: $ipAddress, referrer: $referrer, metadata: $metadata, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationAnalyticsImpl &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.referrer, referrer) ||
                other.referrer == referrer) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invitationId,
      eventType,
      userAgent,
      ipAddress,
      referrer,
      const DeepCollectionEquality().hash(_metadata),
      createdAt);

  /// Create a copy of InvitationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationAnalyticsImplCopyWith<_$InvitationAnalyticsImpl> get copyWith =>
      __$$InvitationAnalyticsImplCopyWithImpl<_$InvitationAnalyticsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)
        $default,
  ) {
    return $default(invitationId, eventType, userAgent, ipAddress, referrer,
        metadata, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)?
        $default,
  ) {
    return $default?.call(invitationId, eventType, userAgent, ipAddress,
        referrer, metadata, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String eventType,
            String? userAgent,
            String? ipAddress,
            String? referrer,
            Map<String, dynamic>? metadata,
            DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(invitationId, eventType, userAgent, ipAddress, referrer,
          metadata, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationAnalytics value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationAnalytics value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationAnalytics value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _InvitationAnalytics implements InvitationAnalytics {
  const factory _InvitationAnalytics(
      {required final int invitationId,
      required final String eventType,
      final String? userAgent,
      final String? ipAddress,
      final String? referrer,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt}) = _$InvitationAnalyticsImpl;

  factory _InvitationAnalytics.fromJson(Map<String, dynamic> json) =
      _$InvitationAnalyticsImpl.fromJson;

  @override
  int get invitationId;
  @override
  String get eventType;
  @override
  String? get userAgent;
  @override
  String? get ipAddress;
  @override
  String? get referrer;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;

  /// Create a copy of InvitationAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationAnalyticsImplCopyWith<_$InvitationAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsSummary _$AnalyticsSummaryFromJson(Map<String, dynamic> json) {
  return _AnalyticsSummary.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsSummary {
  int get sent => throw _privateConstructorUsedError;
  int get clicked => throw _privateConstructorUsedError;
  int get registered => throw _privateConstructorUsedError;
  int get joined => throw _privateConstructorUsedError;
  int get rejected => throw _privateConstructorUsedError;
  double get clickRate => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AnalyticsSummary value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AnalyticsSummary value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AnalyticsSummary value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this AnalyticsSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsSummaryCopyWith<AnalyticsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsSummaryCopyWith<$Res> {
  factory $AnalyticsSummaryCopyWith(
          AnalyticsSummary value, $Res Function(AnalyticsSummary) then) =
      _$AnalyticsSummaryCopyWithImpl<$Res, AnalyticsSummary>;
  @useResult
  $Res call(
      {int sent,
      int clicked,
      int registered,
      int joined,
      int rejected,
      double clickRate,
      double conversionRate});
}

/// @nodoc
class _$AnalyticsSummaryCopyWithImpl<$Res, $Val extends AnalyticsSummary>
    implements $AnalyticsSummaryCopyWith<$Res> {
  _$AnalyticsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sent = null,
    Object? clicked = null,
    Object? registered = null,
    Object? joined = null,
    Object? rejected = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_value.copyWith(
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      clicked: null == clicked
          ? _value.clicked
          : clicked // ignore: cast_nullable_to_non_nullable
              as int,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as int,
      joined: null == joined
          ? _value.joined
          : joined // ignore: cast_nullable_to_non_nullable
              as int,
      rejected: null == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsSummaryImplCopyWith<$Res>
    implements $AnalyticsSummaryCopyWith<$Res> {
  factory _$$AnalyticsSummaryImplCopyWith(_$AnalyticsSummaryImpl value,
          $Res Function(_$AnalyticsSummaryImpl) then) =
      __$$AnalyticsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sent,
      int clicked,
      int registered,
      int joined,
      int rejected,
      double clickRate,
      double conversionRate});
}

/// @nodoc
class __$$AnalyticsSummaryImplCopyWithImpl<$Res>
    extends _$AnalyticsSummaryCopyWithImpl<$Res, _$AnalyticsSummaryImpl>
    implements _$$AnalyticsSummaryImplCopyWith<$Res> {
  __$$AnalyticsSummaryImplCopyWithImpl(_$AnalyticsSummaryImpl _value,
      $Res Function(_$AnalyticsSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sent = null,
    Object? clicked = null,
    Object? registered = null,
    Object? joined = null,
    Object? rejected = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_$AnalyticsSummaryImpl(
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as int,
      clicked: null == clicked
          ? _value.clicked
          : clicked // ignore: cast_nullable_to_non_nullable
              as int,
      registered: null == registered
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as int,
      joined: null == joined
          ? _value.joined
          : joined // ignore: cast_nullable_to_non_nullable
              as int,
      rejected: null == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsSummaryImpl implements _AnalyticsSummary {
  const _$AnalyticsSummaryImpl(
      {required this.sent,
      required this.clicked,
      required this.registered,
      required this.joined,
      required this.rejected,
      required this.clickRate,
      required this.conversionRate});

  factory _$AnalyticsSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsSummaryImplFromJson(json);

  @override
  final int sent;
  @override
  final int clicked;
  @override
  final int registered;
  @override
  final int joined;
  @override
  final int rejected;
  @override
  final double clickRate;
  @override
  final double conversionRate;

  @override
  String toString() {
    return 'AnalyticsSummary(sent: $sent, clicked: $clicked, registered: $registered, joined: $joined, rejected: $rejected, clickRate: $clickRate, conversionRate: $conversionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsSummaryImpl &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.clicked, clicked) || other.clicked == clicked) &&
            (identical(other.registered, registered) ||
                other.registered == registered) &&
            (identical(other.joined, joined) || other.joined == joined) &&
            (identical(other.rejected, rejected) ||
                other.rejected == rejected) &&
            (identical(other.clickRate, clickRate) ||
                other.clickRate == clickRate) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sent, clicked, registered,
      joined, rejected, clickRate, conversionRate);

  /// Create a copy of AnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsSummaryImplCopyWith<_$AnalyticsSummaryImpl> get copyWith =>
      __$$AnalyticsSummaryImplCopyWithImpl<_$AnalyticsSummaryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)
        $default,
  ) {
    return $default(
        sent, clicked, registered, joined, rejected, clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)?
        $default,
  ) {
    return $default?.call(
        sent, clicked, registered, joined, rejected, clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int sent, int clicked, int registered, int joined,
            int rejected, double clickRate, double conversionRate)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(sent, clicked, registered, joined, rejected, clickRate,
          conversionRate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AnalyticsSummary value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AnalyticsSummary value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AnalyticsSummary value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsSummaryImplToJson(
      this,
    );
  }
}

abstract class _AnalyticsSummary implements AnalyticsSummary {
  const factory _AnalyticsSummary(
      {required final int sent,
      required final int clicked,
      required final int registered,
      required final int joined,
      required final int rejected,
      required final double clickRate,
      required final double conversionRate}) = _$AnalyticsSummaryImpl;

  factory _AnalyticsSummary.fromJson(Map<String, dynamic> json) =
      _$AnalyticsSummaryImpl.fromJson;

  @override
  int get sent;
  @override
  int get clicked;
  @override
  int get registered;
  @override
  int get joined;
  @override
  int get rejected;
  @override
  double get clickRate;
  @override
  double get conversionRate;

  /// Create a copy of AnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsSummaryImplCopyWith<_$AnalyticsSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvitationPerformance _$InvitationPerformanceFromJson(
    Map<String, dynamic> json) {
  return _InvitationPerformance.fromJson(json);
}

/// @nodoc
mixin _$InvitationPerformance {
  int get invitationId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get clicks => throw _privateConstructorUsedError;
  int get joins => throw _privateConstructorUsedError;
  double get clickRate => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationPerformance value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationPerformance value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationPerformance value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationPerformanceCopyWith<InvitationPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationPerformanceCopyWith<$Res> {
  factory $InvitationPerformanceCopyWith(InvitationPerformance value,
          $Res Function(InvitationPerformance) then) =
      _$InvitationPerformanceCopyWithImpl<$Res, InvitationPerformance>;
  @useResult
  $Res call(
      {int invitationId,
      String createdBy,
      DateTime createdAt,
      String status,
      int clicks,
      int joins,
      double clickRate,
      double conversionRate});
}

/// @nodoc
class _$InvitationPerformanceCopyWithImpl<$Res,
        $Val extends InvitationPerformance>
    implements $InvitationPerformanceCopyWith<$Res> {
  _$InvitationPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitationId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? status = null,
    Object? clicks = null,
    Object? joins = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_value.copyWith(
      invitationId: null == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clicks: null == clicks
          ? _value.clicks
          : clicks // ignore: cast_nullable_to_non_nullable
              as int,
      joins: null == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationPerformanceImplCopyWith<$Res>
    implements $InvitationPerformanceCopyWith<$Res> {
  factory _$$InvitationPerformanceImplCopyWith(
          _$InvitationPerformanceImpl value,
          $Res Function(_$InvitationPerformanceImpl) then) =
      __$$InvitationPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int invitationId,
      String createdBy,
      DateTime createdAt,
      String status,
      int clicks,
      int joins,
      double clickRate,
      double conversionRate});
}

/// @nodoc
class __$$InvitationPerformanceImplCopyWithImpl<$Res>
    extends _$InvitationPerformanceCopyWithImpl<$Res,
        _$InvitationPerformanceImpl>
    implements _$$InvitationPerformanceImplCopyWith<$Res> {
  __$$InvitationPerformanceImplCopyWithImpl(_$InvitationPerformanceImpl _value,
      $Res Function(_$InvitationPerformanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitationId = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? status = null,
    Object? clicks = null,
    Object? joins = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_$InvitationPerformanceImpl(
      invitationId: null == invitationId
          ? _value.invitationId
          : invitationId // ignore: cast_nullable_to_non_nullable
              as int,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      clicks: null == clicks
          ? _value.clicks
          : clicks // ignore: cast_nullable_to_non_nullable
              as int,
      joins: null == joins
          ? _value.joins
          : joins // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as double,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationPerformanceImpl implements _InvitationPerformance {
  const _$InvitationPerformanceImpl(
      {required this.invitationId,
      required this.createdBy,
      required this.createdAt,
      required this.status,
      required this.clicks,
      required this.joins,
      required this.clickRate,
      required this.conversionRate});

  factory _$InvitationPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationPerformanceImplFromJson(json);

  @override
  final int invitationId;
  @override
  final String createdBy;
  @override
  final DateTime createdAt;
  @override
  final String status;
  @override
  final int clicks;
  @override
  final int joins;
  @override
  final double clickRate;
  @override
  final double conversionRate;

  @override
  String toString() {
    return 'InvitationPerformance(invitationId: $invitationId, createdBy: $createdBy, createdAt: $createdAt, status: $status, clicks: $clicks, joins: $joins, clickRate: $clickRate, conversionRate: $conversionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationPerformanceImpl &&
            (identical(other.invitationId, invitationId) ||
                other.invitationId == invitationId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.clicks, clicks) || other.clicks == clicks) &&
            (identical(other.joins, joins) || other.joins == joins) &&
            (identical(other.clickRate, clickRate) ||
                other.clickRate == clickRate) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, invitationId, createdBy,
      createdAt, status, clicks, joins, clickRate, conversionRate);

  /// Create a copy of InvitationPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationPerformanceImplCopyWith<_$InvitationPerformanceImpl>
      get copyWith => __$$InvitationPerformanceImplCopyWithImpl<
          _$InvitationPerformanceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)
        $default,
  ) {
    return $default(invitationId, createdBy, createdAt, status, clicks, joins,
        clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)?
        $default,
  ) {
    return $default?.call(invitationId, createdBy, createdAt, status, clicks,
        joins, clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int invitationId,
            String createdBy,
            DateTime createdAt,
            String status,
            int clicks,
            int joins,
            double clickRate,
            double conversionRate)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(invitationId, createdBy, createdAt, status, clicks, joins,
          clickRate, conversionRate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationPerformance value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationPerformance value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationPerformance value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationPerformanceImplToJson(
      this,
    );
  }
}

abstract class _InvitationPerformance implements InvitationPerformance {
  const factory _InvitationPerformance(
      {required final int invitationId,
      required final String createdBy,
      required final DateTime createdAt,
      required final String status,
      required final int clicks,
      required final int joins,
      required final double clickRate,
      required final double conversionRate}) = _$InvitationPerformanceImpl;

  factory _InvitationPerformance.fromJson(Map<String, dynamic> json) =
      _$InvitationPerformanceImpl.fromJson;

  @override
  int get invitationId;
  @override
  String get createdBy;
  @override
  DateTime get createdAt;
  @override
  String get status;
  @override
  int get clicks;
  @override
  int get joins;
  @override
  double get clickRate;
  @override
  double get conversionRate;

  /// Create a copy of InvitationPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationPerformanceImplCopyWith<_$InvitationPerformanceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GroupAnalytics _$GroupAnalyticsFromJson(Map<String, dynamic> json) {
  return _GroupAnalytics.fromJson(json);
}

/// @nodoc
mixin _$GroupAnalytics {
  AnalyticsPeriod get period => throw _privateConstructorUsedError;
  GroupAnalyticsSummary get summary => throw _privateConstructorUsedError;
  List<JoinRequestStat> get joinRequestStats =>
      throw _privateConstructorUsedError;
  Map<String, List<DailyActivity>> get dailyActivity =>
      throw _privateConstructorUsedError;
  List<InvitationPerformance> get topPerformers =>
      throw _privateConstructorUsedError;
  List<InvitationPerformance> get allInvitations =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GroupAnalytics value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GroupAnalytics value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GroupAnalytics value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GroupAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupAnalyticsCopyWith<GroupAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupAnalyticsCopyWith<$Res> {
  factory $GroupAnalyticsCopyWith(
          GroupAnalytics value, $Res Function(GroupAnalytics) then) =
      _$GroupAnalyticsCopyWithImpl<$Res, GroupAnalytics>;
  @useResult
  $Res call(
      {AnalyticsPeriod period,
      GroupAnalyticsSummary summary,
      List<JoinRequestStat> joinRequestStats,
      Map<String, List<DailyActivity>> dailyActivity,
      List<InvitationPerformance> topPerformers,
      List<InvitationPerformance> allInvitations});

  $AnalyticsPeriodCopyWith<$Res> get period;
  $GroupAnalyticsSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$GroupAnalyticsCopyWithImpl<$Res, $Val extends GroupAnalytics>
    implements $GroupAnalyticsCopyWith<$Res> {
  _$GroupAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? summary = null,
    Object? joinRequestStats = null,
    Object? dailyActivity = null,
    Object? topPerformers = null,
    Object? allInvitations = null,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalyticsPeriod,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as GroupAnalyticsSummary,
      joinRequestStats: null == joinRequestStats
          ? _value.joinRequestStats
          : joinRequestStats // ignore: cast_nullable_to_non_nullable
              as List<JoinRequestStat>,
      dailyActivity: null == dailyActivity
          ? _value.dailyActivity
          : dailyActivity // ignore: cast_nullable_to_non_nullable
              as Map<String, List<DailyActivity>>,
      topPerformers: null == topPerformers
          ? _value.topPerformers
          : topPerformers // ignore: cast_nullable_to_non_nullable
              as List<InvitationPerformance>,
      allInvitations: null == allInvitations
          ? _value.allInvitations
          : allInvitations // ignore: cast_nullable_to_non_nullable
              as List<InvitationPerformance>,
    ) as $Val);
  }

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalyticsPeriodCopyWith<$Res> get period {
    return $AnalyticsPeriodCopyWith<$Res>(_value.period, (value) {
      return _then(_value.copyWith(period: value) as $Val);
    });
  }

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GroupAnalyticsSummaryCopyWith<$Res> get summary {
    return $GroupAnalyticsSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupAnalyticsImplCopyWith<$Res>
    implements $GroupAnalyticsCopyWith<$Res> {
  factory _$$GroupAnalyticsImplCopyWith(_$GroupAnalyticsImpl value,
          $Res Function(_$GroupAnalyticsImpl) then) =
      __$$GroupAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AnalyticsPeriod period,
      GroupAnalyticsSummary summary,
      List<JoinRequestStat> joinRequestStats,
      Map<String, List<DailyActivity>> dailyActivity,
      List<InvitationPerformance> topPerformers,
      List<InvitationPerformance> allInvitations});

  @override
  $AnalyticsPeriodCopyWith<$Res> get period;
  @override
  $GroupAnalyticsSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$GroupAnalyticsImplCopyWithImpl<$Res>
    extends _$GroupAnalyticsCopyWithImpl<$Res, _$GroupAnalyticsImpl>
    implements _$$GroupAnalyticsImplCopyWith<$Res> {
  __$$GroupAnalyticsImplCopyWithImpl(
      _$GroupAnalyticsImpl _value, $Res Function(_$GroupAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? summary = null,
    Object? joinRequestStats = null,
    Object? dailyActivity = null,
    Object? topPerformers = null,
    Object? allInvitations = null,
  }) {
    return _then(_$GroupAnalyticsImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalyticsPeriod,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as GroupAnalyticsSummary,
      joinRequestStats: null == joinRequestStats
          ? _value._joinRequestStats
          : joinRequestStats // ignore: cast_nullable_to_non_nullable
              as List<JoinRequestStat>,
      dailyActivity: null == dailyActivity
          ? _value._dailyActivity
          : dailyActivity // ignore: cast_nullable_to_non_nullable
              as Map<String, List<DailyActivity>>,
      topPerformers: null == topPerformers
          ? _value._topPerformers
          : topPerformers // ignore: cast_nullable_to_non_nullable
              as List<InvitationPerformance>,
      allInvitations: null == allInvitations
          ? _value._allInvitations
          : allInvitations // ignore: cast_nullable_to_non_nullable
              as List<InvitationPerformance>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupAnalyticsImpl implements _GroupAnalytics {
  const _$GroupAnalyticsImpl(
      {required this.period,
      required this.summary,
      required final List<JoinRequestStat> joinRequestStats,
      required final Map<String, List<DailyActivity>> dailyActivity,
      required final List<InvitationPerformance> topPerformers,
      required final List<InvitationPerformance> allInvitations})
      : _joinRequestStats = joinRequestStats,
        _dailyActivity = dailyActivity,
        _topPerformers = topPerformers,
        _allInvitations = allInvitations;

  factory _$GroupAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupAnalyticsImplFromJson(json);

  @override
  final AnalyticsPeriod period;
  @override
  final GroupAnalyticsSummary summary;
  final List<JoinRequestStat> _joinRequestStats;
  @override
  List<JoinRequestStat> get joinRequestStats {
    if (_joinRequestStats is EqualUnmodifiableListView)
      return _joinRequestStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinRequestStats);
  }

  final Map<String, List<DailyActivity>> _dailyActivity;
  @override
  Map<String, List<DailyActivity>> get dailyActivity {
    if (_dailyActivity is EqualUnmodifiableMapView) return _dailyActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dailyActivity);
  }

  final List<InvitationPerformance> _topPerformers;
  @override
  List<InvitationPerformance> get topPerformers {
    if (_topPerformers is EqualUnmodifiableListView) return _topPerformers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topPerformers);
  }

  final List<InvitationPerformance> _allInvitations;
  @override
  List<InvitationPerformance> get allInvitations {
    if (_allInvitations is EqualUnmodifiableListView) return _allInvitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allInvitations);
  }

  @override
  String toString() {
    return 'GroupAnalytics(period: $period, summary: $summary, joinRequestStats: $joinRequestStats, dailyActivity: $dailyActivity, topPerformers: $topPerformers, allInvitations: $allInvitations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupAnalyticsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._joinRequestStats, _joinRequestStats) &&
            const DeepCollectionEquality()
                .equals(other._dailyActivity, _dailyActivity) &&
            const DeepCollectionEquality()
                .equals(other._topPerformers, _topPerformers) &&
            const DeepCollectionEquality()
                .equals(other._allInvitations, _allInvitations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      summary,
      const DeepCollectionEquality().hash(_joinRequestStats),
      const DeepCollectionEquality().hash(_dailyActivity),
      const DeepCollectionEquality().hash(_topPerformers),
      const DeepCollectionEquality().hash(_allInvitations));

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupAnalyticsImplCopyWith<_$GroupAnalyticsImpl> get copyWith =>
      __$$GroupAnalyticsImplCopyWithImpl<_$GroupAnalyticsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)
        $default,
  ) {
    return $default(period, summary, joinRequestStats, dailyActivity,
        topPerformers, allInvitations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)?
        $default,
  ) {
    return $default?.call(period, summary, joinRequestStats, dailyActivity,
        topPerformers, allInvitations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            GroupAnalyticsSummary summary,
            List<JoinRequestStat> joinRequestStats,
            Map<String, List<DailyActivity>> dailyActivity,
            List<InvitationPerformance> topPerformers,
            List<InvitationPerformance> allInvitations)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(period, summary, joinRequestStats, dailyActivity,
          topPerformers, allInvitations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GroupAnalytics value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GroupAnalytics value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GroupAnalytics value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _GroupAnalytics implements GroupAnalytics {
  const factory _GroupAnalytics(
          {required final AnalyticsPeriod period,
          required final GroupAnalyticsSummary summary,
          required final List<JoinRequestStat> joinRequestStats,
          required final Map<String, List<DailyActivity>> dailyActivity,
          required final List<InvitationPerformance> topPerformers,
          required final List<InvitationPerformance> allInvitations}) =
      _$GroupAnalyticsImpl;

  factory _GroupAnalytics.fromJson(Map<String, dynamic> json) =
      _$GroupAnalyticsImpl.fromJson;

  @override
  AnalyticsPeriod get period;
  @override
  GroupAnalyticsSummary get summary;
  @override
  List<JoinRequestStat> get joinRequestStats;
  @override
  Map<String, List<DailyActivity>> get dailyActivity;
  @override
  List<InvitationPerformance> get topPerformers;
  @override
  List<InvitationPerformance> get allInvitations;

  /// Create a copy of GroupAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupAnalyticsImplCopyWith<_$GroupAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalyticsPeriod _$AnalyticsPeriodFromJson(Map<String, dynamic> json) {
  return _AnalyticsPeriod.fromJson(json);
}

/// @nodoc
mixin _$AnalyticsPeriod {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String start, String end) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String start, String end)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String start, String end)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AnalyticsPeriod value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AnalyticsPeriod value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AnalyticsPeriod value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this AnalyticsPeriod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalyticsPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalyticsPeriodCopyWith<AnalyticsPeriod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsPeriodCopyWith<$Res> {
  factory $AnalyticsPeriodCopyWith(
          AnalyticsPeriod value, $Res Function(AnalyticsPeriod) then) =
      _$AnalyticsPeriodCopyWithImpl<$Res, AnalyticsPeriod>;
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class _$AnalyticsPeriodCopyWithImpl<$Res, $Val extends AnalyticsPeriod>
    implements $AnalyticsPeriodCopyWith<$Res> {
  _$AnalyticsPeriodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalyticsPeriodImplCopyWith<$Res>
    implements $AnalyticsPeriodCopyWith<$Res> {
  factory _$$AnalyticsPeriodImplCopyWith(_$AnalyticsPeriodImpl value,
          $Res Function(_$AnalyticsPeriodImpl) then) =
      __$$AnalyticsPeriodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end});
}

/// @nodoc
class __$$AnalyticsPeriodImplCopyWithImpl<$Res>
    extends _$AnalyticsPeriodCopyWithImpl<$Res, _$AnalyticsPeriodImpl>
    implements _$$AnalyticsPeriodImplCopyWith<$Res> {
  __$$AnalyticsPeriodImplCopyWithImpl(
      _$AnalyticsPeriodImpl _value, $Res Function(_$AnalyticsPeriodImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalyticsPeriod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$AnalyticsPeriodImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalyticsPeriodImpl implements _AnalyticsPeriod {
  const _$AnalyticsPeriodImpl({required this.start, required this.end});

  factory _$AnalyticsPeriodImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalyticsPeriodImplFromJson(json);

  @override
  final String start;
  @override
  final String end;

  @override
  String toString() {
    return 'AnalyticsPeriod(start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsPeriodImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end);

  /// Create a copy of AnalyticsPeriod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsPeriodImplCopyWith<_$AnalyticsPeriodImpl> get copyWith =>
      __$$AnalyticsPeriodImplCopyWithImpl<_$AnalyticsPeriodImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String start, String end) $default,
  ) {
    return $default(start, end);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String start, String end)? $default,
  ) {
    return $default?.call(start, end);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String start, String end)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(start, end);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AnalyticsPeriod value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AnalyticsPeriod value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AnalyticsPeriod value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalyticsPeriodImplToJson(
      this,
    );
  }
}

abstract class _AnalyticsPeriod implements AnalyticsPeriod {
  const factory _AnalyticsPeriod(
      {required final String start,
      required final String end}) = _$AnalyticsPeriodImpl;

  factory _AnalyticsPeriod.fromJson(Map<String, dynamic> json) =
      _$AnalyticsPeriodImpl.fromJson;

  @override
  String get start;
  @override
  String get end;

  /// Create a copy of AnalyticsPeriod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsPeriodImplCopyWith<_$AnalyticsPeriodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GroupAnalyticsSummary _$GroupAnalyticsSummaryFromJson(
    Map<String, dynamic> json) {
  return _GroupAnalyticsSummary.fromJson(json);
}

/// @nodoc
mixin _$GroupAnalyticsSummary {
  int get totalInvitations => throw _privateConstructorUsedError;
  int get totalClicks => throw _privateConstructorUsedError;
  int get totalJoins => throw _privateConstructorUsedError;
  int get totalRejected => throw _privateConstructorUsedError;
  String get clickRate => throw _privateConstructorUsedError;
  String get conversionRate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GroupAnalyticsSummary value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GroupAnalyticsSummary value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GroupAnalyticsSummary value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this GroupAnalyticsSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupAnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupAnalyticsSummaryCopyWith<GroupAnalyticsSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupAnalyticsSummaryCopyWith<$Res> {
  factory $GroupAnalyticsSummaryCopyWith(GroupAnalyticsSummary value,
          $Res Function(GroupAnalyticsSummary) then) =
      _$GroupAnalyticsSummaryCopyWithImpl<$Res, GroupAnalyticsSummary>;
  @useResult
  $Res call(
      {int totalInvitations,
      int totalClicks,
      int totalJoins,
      int totalRejected,
      String clickRate,
      String conversionRate});
}

/// @nodoc
class _$GroupAnalyticsSummaryCopyWithImpl<$Res,
        $Val extends GroupAnalyticsSummary>
    implements $GroupAnalyticsSummaryCopyWith<$Res> {
  _$GroupAnalyticsSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupAnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvitations = null,
    Object? totalClicks = null,
    Object? totalJoins = null,
    Object? totalRejected = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_value.copyWith(
      totalInvitations: null == totalInvitations
          ? _value.totalInvitations
          : totalInvitations // ignore: cast_nullable_to_non_nullable
              as int,
      totalClicks: null == totalClicks
          ? _value.totalClicks
          : totalClicks // ignore: cast_nullable_to_non_nullable
              as int,
      totalJoins: null == totalJoins
          ? _value.totalJoins
          : totalJoins // ignore: cast_nullable_to_non_nullable
              as int,
      totalRejected: null == totalRejected
          ? _value.totalRejected
          : totalRejected // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupAnalyticsSummaryImplCopyWith<$Res>
    implements $GroupAnalyticsSummaryCopyWith<$Res> {
  factory _$$GroupAnalyticsSummaryImplCopyWith(
          _$GroupAnalyticsSummaryImpl value,
          $Res Function(_$GroupAnalyticsSummaryImpl) then) =
      __$$GroupAnalyticsSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalInvitations,
      int totalClicks,
      int totalJoins,
      int totalRejected,
      String clickRate,
      String conversionRate});
}

/// @nodoc
class __$$GroupAnalyticsSummaryImplCopyWithImpl<$Res>
    extends _$GroupAnalyticsSummaryCopyWithImpl<$Res,
        _$GroupAnalyticsSummaryImpl>
    implements _$$GroupAnalyticsSummaryImplCopyWith<$Res> {
  __$$GroupAnalyticsSummaryImplCopyWithImpl(_$GroupAnalyticsSummaryImpl _value,
      $Res Function(_$GroupAnalyticsSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupAnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalInvitations = null,
    Object? totalClicks = null,
    Object? totalJoins = null,
    Object? totalRejected = null,
    Object? clickRate = null,
    Object? conversionRate = null,
  }) {
    return _then(_$GroupAnalyticsSummaryImpl(
      totalInvitations: null == totalInvitations
          ? _value.totalInvitations
          : totalInvitations // ignore: cast_nullable_to_non_nullable
              as int,
      totalClicks: null == totalClicks
          ? _value.totalClicks
          : totalClicks // ignore: cast_nullable_to_non_nullable
              as int,
      totalJoins: null == totalJoins
          ? _value.totalJoins
          : totalJoins // ignore: cast_nullable_to_non_nullable
              as int,
      totalRejected: null == totalRejected
          ? _value.totalRejected
          : totalRejected // ignore: cast_nullable_to_non_nullable
              as int,
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupAnalyticsSummaryImpl implements _GroupAnalyticsSummary {
  const _$GroupAnalyticsSummaryImpl(
      {required this.totalInvitations,
      required this.totalClicks,
      required this.totalJoins,
      required this.totalRejected,
      required this.clickRate,
      required this.conversionRate});

  factory _$GroupAnalyticsSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupAnalyticsSummaryImplFromJson(json);

  @override
  final int totalInvitations;
  @override
  final int totalClicks;
  @override
  final int totalJoins;
  @override
  final int totalRejected;
  @override
  final String clickRate;
  @override
  final String conversionRate;

  @override
  String toString() {
    return 'GroupAnalyticsSummary(totalInvitations: $totalInvitations, totalClicks: $totalClicks, totalJoins: $totalJoins, totalRejected: $totalRejected, clickRate: $clickRate, conversionRate: $conversionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupAnalyticsSummaryImpl &&
            (identical(other.totalInvitations, totalInvitations) ||
                other.totalInvitations == totalInvitations) &&
            (identical(other.totalClicks, totalClicks) ||
                other.totalClicks == totalClicks) &&
            (identical(other.totalJoins, totalJoins) ||
                other.totalJoins == totalJoins) &&
            (identical(other.totalRejected, totalRejected) ||
                other.totalRejected == totalRejected) &&
            (identical(other.clickRate, clickRate) ||
                other.clickRate == clickRate) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalInvitations, totalClicks,
      totalJoins, totalRejected, clickRate, conversionRate);

  /// Create a copy of GroupAnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupAnalyticsSummaryImplCopyWith<_$GroupAnalyticsSummaryImpl>
      get copyWith => __$$GroupAnalyticsSummaryImplCopyWithImpl<
          _$GroupAnalyticsSummaryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)
        $default,
  ) {
    return $default(totalInvitations, totalClicks, totalJoins, totalRejected,
        clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)?
        $default,
  ) {
    return $default?.call(totalInvitations, totalClicks, totalJoins,
        totalRejected, clickRate, conversionRate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int totalInvitations, int totalClicks, int totalJoins,
            int totalRejected, String clickRate, String conversionRate)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(totalInvitations, totalClicks, totalJoins, totalRejected,
          clickRate, conversionRate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GroupAnalyticsSummary value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GroupAnalyticsSummary value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GroupAnalyticsSummary value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupAnalyticsSummaryImplToJson(
      this,
    );
  }
}

abstract class _GroupAnalyticsSummary implements GroupAnalyticsSummary {
  const factory _GroupAnalyticsSummary(
      {required final int totalInvitations,
      required final int totalClicks,
      required final int totalJoins,
      required final int totalRejected,
      required final String clickRate,
      required final String conversionRate}) = _$GroupAnalyticsSummaryImpl;

  factory _GroupAnalyticsSummary.fromJson(Map<String, dynamic> json) =
      _$GroupAnalyticsSummaryImpl.fromJson;

  @override
  int get totalInvitations;
  @override
  int get totalClicks;
  @override
  int get totalJoins;
  @override
  int get totalRejected;
  @override
  String get clickRate;
  @override
  String get conversionRate;

  /// Create a copy of GroupAnalyticsSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupAnalyticsSummaryImplCopyWith<_$GroupAnalyticsSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

JoinRequestStat _$JoinRequestStatFromJson(Map<String, dynamic> json) {
  return _JoinRequestStat.fromJson(json);
}

/// @nodoc
mixin _$JoinRequestStat {
  String get status => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String status, String source, int count) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String status, String source, int count)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String status, String source, int count)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_JoinRequestStat value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_JoinRequestStat value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_JoinRequestStat value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this JoinRequestStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JoinRequestStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JoinRequestStatCopyWith<JoinRequestStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRequestStatCopyWith<$Res> {
  factory $JoinRequestStatCopyWith(
          JoinRequestStat value, $Res Function(JoinRequestStat) then) =
      _$JoinRequestStatCopyWithImpl<$Res, JoinRequestStat>;
  @useResult
  $Res call({String status, String source, int count});
}

/// @nodoc
class _$JoinRequestStatCopyWithImpl<$Res, $Val extends JoinRequestStat>
    implements $JoinRequestStatCopyWith<$Res> {
  _$JoinRequestStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JoinRequestStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? source = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JoinRequestStatImplCopyWith<$Res>
    implements $JoinRequestStatCopyWith<$Res> {
  factory _$$JoinRequestStatImplCopyWith(_$JoinRequestStatImpl value,
          $Res Function(_$JoinRequestStatImpl) then) =
      __$$JoinRequestStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String source, int count});
}

/// @nodoc
class __$$JoinRequestStatImplCopyWithImpl<$Res>
    extends _$JoinRequestStatCopyWithImpl<$Res, _$JoinRequestStatImpl>
    implements _$$JoinRequestStatImplCopyWith<$Res> {
  __$$JoinRequestStatImplCopyWithImpl(
      _$JoinRequestStatImpl _value, $Res Function(_$JoinRequestStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of JoinRequestStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? source = null,
    Object? count = null,
  }) {
    return _then(_$JoinRequestStatImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JoinRequestStatImpl implements _JoinRequestStat {
  const _$JoinRequestStatImpl(
      {required this.status, required this.source, required this.count});

  factory _$JoinRequestStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$JoinRequestStatImplFromJson(json);

  @override
  final String status;
  @override
  final String source;
  @override
  final int count;

  @override
  String toString() {
    return 'JoinRequestStat(status: $status, source: $source, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinRequestStatImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, source, count);

  /// Create a copy of JoinRequestStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinRequestStatImplCopyWith<_$JoinRequestStatImpl> get copyWith =>
      __$$JoinRequestStatImplCopyWithImpl<_$JoinRequestStatImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String status, String source, int count) $default,
  ) {
    return $default(status, source, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String status, String source, int count)? $default,
  ) {
    return $default?.call(status, source, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String status, String source, int count)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(status, source, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_JoinRequestStat value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_JoinRequestStat value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_JoinRequestStat value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JoinRequestStatImplToJson(
      this,
    );
  }
}

abstract class _JoinRequestStat implements JoinRequestStat {
  const factory _JoinRequestStat(
      {required final String status,
      required final String source,
      required final int count}) = _$JoinRequestStatImpl;

  factory _JoinRequestStat.fromJson(Map<String, dynamic> json) =
      _$JoinRequestStatImpl.fromJson;

  @override
  String get status;
  @override
  String get source;
  @override
  int get count;

  /// Create a copy of JoinRequestStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinRequestStatImplCopyWith<_$JoinRequestStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyActivity _$DailyActivityFromJson(Map<String, dynamic> json) {
  return _DailyActivity.fromJson(json);
}

/// @nodoc
mixin _$DailyActivity {
  String get date => throw _privateConstructorUsedError;
  String get eventType => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String date, String eventType, int count) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String date, String eventType, int count)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String date, String eventType, int count)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DailyActivity value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DailyActivity value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DailyActivity value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this DailyActivity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyActivityCopyWith<DailyActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyActivityCopyWith<$Res> {
  factory $DailyActivityCopyWith(
          DailyActivity value, $Res Function(DailyActivity) then) =
      _$DailyActivityCopyWithImpl<$Res, DailyActivity>;
  @useResult
  $Res call({String date, String eventType, int count});
}

/// @nodoc
class _$DailyActivityCopyWithImpl<$Res, $Val extends DailyActivity>
    implements $DailyActivityCopyWith<$Res> {
  _$DailyActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? eventType = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyActivityImplCopyWith<$Res>
    implements $DailyActivityCopyWith<$Res> {
  factory _$$DailyActivityImplCopyWith(
          _$DailyActivityImpl value, $Res Function(_$DailyActivityImpl) then) =
      __$$DailyActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, String eventType, int count});
}

/// @nodoc
class __$$DailyActivityImplCopyWithImpl<$Res>
    extends _$DailyActivityCopyWithImpl<$Res, _$DailyActivityImpl>
    implements _$$DailyActivityImplCopyWith<$Res> {
  __$$DailyActivityImplCopyWithImpl(
      _$DailyActivityImpl _value, $Res Function(_$DailyActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyActivity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? eventType = null,
    Object? count = null,
  }) {
    return _then(_$DailyActivityImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyActivityImpl implements _DailyActivity {
  const _$DailyActivityImpl(
      {required this.date, required this.eventType, required this.count});

  factory _$DailyActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyActivityImplFromJson(json);

  @override
  final String date;
  @override
  final String eventType;
  @override
  final int count;

  @override
  String toString() {
    return 'DailyActivity(date: $date, eventType: $eventType, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyActivityImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, eventType, count);

  /// Create a copy of DailyActivity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyActivityImplCopyWith<_$DailyActivityImpl> get copyWith =>
      __$$DailyActivityImplCopyWithImpl<_$DailyActivityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String date, String eventType, int count) $default,
  ) {
    return $default(date, eventType, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String date, String eventType, int count)? $default,
  ) {
    return $default?.call(date, eventType, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String date, String eventType, int count)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(date, eventType, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DailyActivity value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DailyActivity value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DailyActivity value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyActivityImplToJson(
      this,
    );
  }
}

abstract class _DailyActivity implements DailyActivity {
  const factory _DailyActivity(
      {required final String date,
      required final String eventType,
      required final int count}) = _$DailyActivityImpl;

  factory _DailyActivity.fromJson(Map<String, dynamic> json) =
      _$DailyActivityImpl.fromJson;

  @override
  String get date;
  @override
  String get eventType;
  @override
  int get count;

  /// Create a copy of DailyActivity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyActivityImplCopyWith<_$DailyActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberGrowthAnalytics _$MemberGrowthAnalyticsFromJson(
    Map<String, dynamic> json) {
  return _MemberGrowthAnalytics.fromJson(json);
}

/// @nodoc
mixin _$MemberGrowthAnalytics {
  AnalyticsPeriod get period => throw _privateConstructorUsedError;
  MemberGrowthSummary get summary => throw _privateConstructorUsedError;
  List<DailyGrowth> get dailyGrowth => throw _privateConstructorUsedError;
  List<MemberSource> get memberSources => throw _privateConstructorUsedError;
  Map<String, List<InvitationEffectiveness>> get invitationEffectiveness =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberGrowthAnalytics value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberGrowthAnalytics value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberGrowthAnalytics value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MemberGrowthAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberGrowthAnalyticsCopyWith<MemberGrowthAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberGrowthAnalyticsCopyWith<$Res> {
  factory $MemberGrowthAnalyticsCopyWith(MemberGrowthAnalytics value,
          $Res Function(MemberGrowthAnalytics) then) =
      _$MemberGrowthAnalyticsCopyWithImpl<$Res, MemberGrowthAnalytics>;
  @useResult
  $Res call(
      {AnalyticsPeriod period,
      MemberGrowthSummary summary,
      List<DailyGrowth> dailyGrowth,
      List<MemberSource> memberSources,
      Map<String, List<InvitationEffectiveness>> invitationEffectiveness});

  $AnalyticsPeriodCopyWith<$Res> get period;
  $MemberGrowthSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class _$MemberGrowthAnalyticsCopyWithImpl<$Res,
        $Val extends MemberGrowthAnalytics>
    implements $MemberGrowthAnalyticsCopyWith<$Res> {
  _$MemberGrowthAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? summary = null,
    Object? dailyGrowth = null,
    Object? memberSources = null,
    Object? invitationEffectiveness = null,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalyticsPeriod,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as MemberGrowthSummary,
      dailyGrowth: null == dailyGrowth
          ? _value.dailyGrowth
          : dailyGrowth // ignore: cast_nullable_to_non_nullable
              as List<DailyGrowth>,
      memberSources: null == memberSources
          ? _value.memberSources
          : memberSources // ignore: cast_nullable_to_non_nullable
              as List<MemberSource>,
      invitationEffectiveness: null == invitationEffectiveness
          ? _value.invitationEffectiveness
          : invitationEffectiveness // ignore: cast_nullable_to_non_nullable
              as Map<String, List<InvitationEffectiveness>>,
    ) as $Val);
  }

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalyticsPeriodCopyWith<$Res> get period {
    return $AnalyticsPeriodCopyWith<$Res>(_value.period, (value) {
      return _then(_value.copyWith(period: value) as $Val);
    });
  }

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberGrowthSummaryCopyWith<$Res> get summary {
    return $MemberGrowthSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MemberGrowthAnalyticsImplCopyWith<$Res>
    implements $MemberGrowthAnalyticsCopyWith<$Res> {
  factory _$$MemberGrowthAnalyticsImplCopyWith(
          _$MemberGrowthAnalyticsImpl value,
          $Res Function(_$MemberGrowthAnalyticsImpl) then) =
      __$$MemberGrowthAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AnalyticsPeriod period,
      MemberGrowthSummary summary,
      List<DailyGrowth> dailyGrowth,
      List<MemberSource> memberSources,
      Map<String, List<InvitationEffectiveness>> invitationEffectiveness});

  @override
  $AnalyticsPeriodCopyWith<$Res> get period;
  @override
  $MemberGrowthSummaryCopyWith<$Res> get summary;
}

/// @nodoc
class __$$MemberGrowthAnalyticsImplCopyWithImpl<$Res>
    extends _$MemberGrowthAnalyticsCopyWithImpl<$Res,
        _$MemberGrowthAnalyticsImpl>
    implements _$$MemberGrowthAnalyticsImplCopyWith<$Res> {
  __$$MemberGrowthAnalyticsImplCopyWithImpl(_$MemberGrowthAnalyticsImpl _value,
      $Res Function(_$MemberGrowthAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? summary = null,
    Object? dailyGrowth = null,
    Object? memberSources = null,
    Object? invitationEffectiveness = null,
  }) {
    return _then(_$MemberGrowthAnalyticsImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as AnalyticsPeriod,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as MemberGrowthSummary,
      dailyGrowth: null == dailyGrowth
          ? _value._dailyGrowth
          : dailyGrowth // ignore: cast_nullable_to_non_nullable
              as List<DailyGrowth>,
      memberSources: null == memberSources
          ? _value._memberSources
          : memberSources // ignore: cast_nullable_to_non_nullable
              as List<MemberSource>,
      invitationEffectiveness: null == invitationEffectiveness
          ? _value._invitationEffectiveness
          : invitationEffectiveness // ignore: cast_nullable_to_non_nullable
              as Map<String, List<InvitationEffectiveness>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberGrowthAnalyticsImpl implements _MemberGrowthAnalytics {
  const _$MemberGrowthAnalyticsImpl(
      {required this.period,
      required this.summary,
      required final List<DailyGrowth> dailyGrowth,
      required final List<MemberSource> memberSources,
      required final Map<String, List<InvitationEffectiveness>>
          invitationEffectiveness})
      : _dailyGrowth = dailyGrowth,
        _memberSources = memberSources,
        _invitationEffectiveness = invitationEffectiveness;

  factory _$MemberGrowthAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberGrowthAnalyticsImplFromJson(json);

  @override
  final AnalyticsPeriod period;
  @override
  final MemberGrowthSummary summary;
  final List<DailyGrowth> _dailyGrowth;
  @override
  List<DailyGrowth> get dailyGrowth {
    if (_dailyGrowth is EqualUnmodifiableListView) return _dailyGrowth;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyGrowth);
  }

  final List<MemberSource> _memberSources;
  @override
  List<MemberSource> get memberSources {
    if (_memberSources is EqualUnmodifiableListView) return _memberSources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberSources);
  }

  final Map<String, List<InvitationEffectiveness>> _invitationEffectiveness;
  @override
  Map<String, List<InvitationEffectiveness>> get invitationEffectiveness {
    if (_invitationEffectiveness is EqualUnmodifiableMapView)
      return _invitationEffectiveness;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_invitationEffectiveness);
  }

  @override
  String toString() {
    return 'MemberGrowthAnalytics(period: $period, summary: $summary, dailyGrowth: $dailyGrowth, memberSources: $memberSources, invitationEffectiveness: $invitationEffectiveness)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberGrowthAnalyticsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._dailyGrowth, _dailyGrowth) &&
            const DeepCollectionEquality()
                .equals(other._memberSources, _memberSources) &&
            const DeepCollectionEquality().equals(
                other._invitationEffectiveness, _invitationEffectiveness));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      period,
      summary,
      const DeepCollectionEquality().hash(_dailyGrowth),
      const DeepCollectionEquality().hash(_memberSources),
      const DeepCollectionEquality().hash(_invitationEffectiveness));

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberGrowthAnalyticsImplCopyWith<_$MemberGrowthAnalyticsImpl>
      get copyWith => __$$MemberGrowthAnalyticsImplCopyWithImpl<
          _$MemberGrowthAnalyticsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)
        $default,
  ) {
    return $default(
        period, summary, dailyGrowth, memberSources, invitationEffectiveness);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)?
        $default,
  ) {
    return $default?.call(
        period, summary, dailyGrowth, memberSources, invitationEffectiveness);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AnalyticsPeriod period,
            MemberGrowthSummary summary,
            List<DailyGrowth> dailyGrowth,
            List<MemberSource> memberSources,
            Map<String, List<InvitationEffectiveness>> invitationEffectiveness)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          period, summary, dailyGrowth, memberSources, invitationEffectiveness);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberGrowthAnalytics value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberGrowthAnalytics value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberGrowthAnalytics value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberGrowthAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _MemberGrowthAnalytics implements MemberGrowthAnalytics {
  const factory _MemberGrowthAnalytics(
      {required final AnalyticsPeriod period,
      required final MemberGrowthSummary summary,
      required final List<DailyGrowth> dailyGrowth,
      required final List<MemberSource> memberSources,
      required final Map<String, List<InvitationEffectiveness>>
          invitationEffectiveness}) = _$MemberGrowthAnalyticsImpl;

  factory _MemberGrowthAnalytics.fromJson(Map<String, dynamic> json) =
      _$MemberGrowthAnalyticsImpl.fromJson;

  @override
  AnalyticsPeriod get period;
  @override
  MemberGrowthSummary get summary;
  @override
  List<DailyGrowth> get dailyGrowth;
  @override
  List<MemberSource> get memberSources;
  @override
  Map<String, List<InvitationEffectiveness>> get invitationEffectiveness;

  /// Create a copy of MemberGrowthAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberGrowthAnalyticsImplCopyWith<_$MemberGrowthAnalyticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MemberGrowthSummary _$MemberGrowthSummaryFromJson(Map<String, dynamic> json) {
  return _MemberGrowthSummary.fromJson(json);
}

/// @nodoc
mixin _$MemberGrowthSummary {
  int get newMembers => throw _privateConstructorUsedError;
  String get growthRate => throw _privateConstructorUsedError;
  int get currentTotal => throw _privateConstructorUsedError;
  String get capacityUsage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberGrowthSummary value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberGrowthSummary value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberGrowthSummary value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MemberGrowthSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberGrowthSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberGrowthSummaryCopyWith<MemberGrowthSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberGrowthSummaryCopyWith<$Res> {
  factory $MemberGrowthSummaryCopyWith(
          MemberGrowthSummary value, $Res Function(MemberGrowthSummary) then) =
      _$MemberGrowthSummaryCopyWithImpl<$Res, MemberGrowthSummary>;
  @useResult
  $Res call(
      {int newMembers,
      String growthRate,
      int currentTotal,
      String capacityUsage});
}

/// @nodoc
class _$MemberGrowthSummaryCopyWithImpl<$Res, $Val extends MemberGrowthSummary>
    implements $MemberGrowthSummaryCopyWith<$Res> {
  _$MemberGrowthSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberGrowthSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newMembers = null,
    Object? growthRate = null,
    Object? currentTotal = null,
    Object? capacityUsage = null,
  }) {
    return _then(_value.copyWith(
      newMembers: null == newMembers
          ? _value.newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as int,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as String,
      currentTotal: null == currentTotal
          ? _value.currentTotal
          : currentTotal // ignore: cast_nullable_to_non_nullable
              as int,
      capacityUsage: null == capacityUsage
          ? _value.capacityUsage
          : capacityUsage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberGrowthSummaryImplCopyWith<$Res>
    implements $MemberGrowthSummaryCopyWith<$Res> {
  factory _$$MemberGrowthSummaryImplCopyWith(_$MemberGrowthSummaryImpl value,
          $Res Function(_$MemberGrowthSummaryImpl) then) =
      __$$MemberGrowthSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int newMembers,
      String growthRate,
      int currentTotal,
      String capacityUsage});
}

/// @nodoc
class __$$MemberGrowthSummaryImplCopyWithImpl<$Res>
    extends _$MemberGrowthSummaryCopyWithImpl<$Res, _$MemberGrowthSummaryImpl>
    implements _$$MemberGrowthSummaryImplCopyWith<$Res> {
  __$$MemberGrowthSummaryImplCopyWithImpl(_$MemberGrowthSummaryImpl _value,
      $Res Function(_$MemberGrowthSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberGrowthSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newMembers = null,
    Object? growthRate = null,
    Object? currentTotal = null,
    Object? capacityUsage = null,
  }) {
    return _then(_$MemberGrowthSummaryImpl(
      newMembers: null == newMembers
          ? _value.newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as int,
      growthRate: null == growthRate
          ? _value.growthRate
          : growthRate // ignore: cast_nullable_to_non_nullable
              as String,
      currentTotal: null == currentTotal
          ? _value.currentTotal
          : currentTotal // ignore: cast_nullable_to_non_nullable
              as int,
      capacityUsage: null == capacityUsage
          ? _value.capacityUsage
          : capacityUsage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberGrowthSummaryImpl implements _MemberGrowthSummary {
  const _$MemberGrowthSummaryImpl(
      {required this.newMembers,
      required this.growthRate,
      required this.currentTotal,
      required this.capacityUsage});

  factory _$MemberGrowthSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberGrowthSummaryImplFromJson(json);

  @override
  final int newMembers;
  @override
  final String growthRate;
  @override
  final int currentTotal;
  @override
  final String capacityUsage;

  @override
  String toString() {
    return 'MemberGrowthSummary(newMembers: $newMembers, growthRate: $growthRate, currentTotal: $currentTotal, capacityUsage: $capacityUsage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberGrowthSummaryImpl &&
            (identical(other.newMembers, newMembers) ||
                other.newMembers == newMembers) &&
            (identical(other.growthRate, growthRate) ||
                other.growthRate == growthRate) &&
            (identical(other.currentTotal, currentTotal) ||
                other.currentTotal == currentTotal) &&
            (identical(other.capacityUsage, capacityUsage) ||
                other.capacityUsage == capacityUsage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, newMembers, growthRate, currentTotal, capacityUsage);

  /// Create a copy of MemberGrowthSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberGrowthSummaryImplCopyWith<_$MemberGrowthSummaryImpl> get copyWith =>
      __$$MemberGrowthSummaryImplCopyWithImpl<_$MemberGrowthSummaryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)
        $default,
  ) {
    return $default(newMembers, growthRate, currentTotal, capacityUsage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)?
        $default,
  ) {
    return $default?.call(newMembers, growthRate, currentTotal, capacityUsage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int newMembers, String growthRate, int currentTotal,
            String capacityUsage)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(newMembers, growthRate, currentTotal, capacityUsage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberGrowthSummary value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberGrowthSummary value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberGrowthSummary value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberGrowthSummaryImplToJson(
      this,
    );
  }
}

abstract class _MemberGrowthSummary implements MemberGrowthSummary {
  const factory _MemberGrowthSummary(
      {required final int newMembers,
      required final String growthRate,
      required final int currentTotal,
      required final String capacityUsage}) = _$MemberGrowthSummaryImpl;

  factory _MemberGrowthSummary.fromJson(Map<String, dynamic> json) =
      _$MemberGrowthSummaryImpl.fromJson;

  @override
  int get newMembers;
  @override
  String get growthRate;
  @override
  int get currentTotal;
  @override
  String get capacityUsage;

  /// Create a copy of MemberGrowthSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberGrowthSummaryImplCopyWith<_$MemberGrowthSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyGrowth _$DailyGrowthFromJson(Map<String, dynamic> json) {
  return _DailyGrowth.fromJson(json);
}

/// @nodoc
mixin _$DailyGrowth {
  String get date => throw _privateConstructorUsedError;
  int get newMembers => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String date, int newMembers) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String date, int newMembers)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String date, int newMembers)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DailyGrowth value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DailyGrowth value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DailyGrowth value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this DailyGrowth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyGrowthCopyWith<DailyGrowth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyGrowthCopyWith<$Res> {
  factory $DailyGrowthCopyWith(
          DailyGrowth value, $Res Function(DailyGrowth) then) =
      _$DailyGrowthCopyWithImpl<$Res, DailyGrowth>;
  @useResult
  $Res call({String date, int newMembers});
}

/// @nodoc
class _$DailyGrowthCopyWithImpl<$Res, $Val extends DailyGrowth>
    implements $DailyGrowthCopyWith<$Res> {
  _$DailyGrowthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newMembers = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      newMembers: null == newMembers
          ? _value.newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyGrowthImplCopyWith<$Res>
    implements $DailyGrowthCopyWith<$Res> {
  factory _$$DailyGrowthImplCopyWith(
          _$DailyGrowthImpl value, $Res Function(_$DailyGrowthImpl) then) =
      __$$DailyGrowthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, int newMembers});
}

/// @nodoc
class __$$DailyGrowthImplCopyWithImpl<$Res>
    extends _$DailyGrowthCopyWithImpl<$Res, _$DailyGrowthImpl>
    implements _$$DailyGrowthImplCopyWith<$Res> {
  __$$DailyGrowthImplCopyWithImpl(
      _$DailyGrowthImpl _value, $Res Function(_$DailyGrowthImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? newMembers = null,
  }) {
    return _then(_$DailyGrowthImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      newMembers: null == newMembers
          ? _value.newMembers
          : newMembers // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyGrowthImpl implements _DailyGrowth {
  const _$DailyGrowthImpl({required this.date, required this.newMembers});

  factory _$DailyGrowthImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyGrowthImplFromJson(json);

  @override
  final String date;
  @override
  final int newMembers;

  @override
  String toString() {
    return 'DailyGrowth(date: $date, newMembers: $newMembers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyGrowthImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.newMembers, newMembers) ||
                other.newMembers == newMembers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, newMembers);

  /// Create a copy of DailyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyGrowthImplCopyWith<_$DailyGrowthImpl> get copyWith =>
      __$$DailyGrowthImplCopyWithImpl<_$DailyGrowthImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String date, int newMembers) $default,
  ) {
    return $default(date, newMembers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String date, int newMembers)? $default,
  ) {
    return $default?.call(date, newMembers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String date, int newMembers)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(date, newMembers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DailyGrowth value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DailyGrowth value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DailyGrowth value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyGrowthImplToJson(
      this,
    );
  }
}

abstract class _DailyGrowth implements DailyGrowth {
  const factory _DailyGrowth(
      {required final String date,
      required final int newMembers}) = _$DailyGrowthImpl;

  factory _DailyGrowth.fromJson(Map<String, dynamic> json) =
      _$DailyGrowthImpl.fromJson;

  @override
  String get date;
  @override
  int get newMembers;

  /// Create a copy of DailyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyGrowthImplCopyWith<_$DailyGrowthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemberSource _$MemberSourceFromJson(Map<String, dynamic> json) {
  return _MemberSource.fromJson(json);
}

/// @nodoc
mixin _$MemberSource {
  String get joinReason => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String joinReason, int count) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String joinReason, int count)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String joinReason, int count)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberSource value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberSource value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberSource value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this MemberSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemberSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemberSourceCopyWith<MemberSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberSourceCopyWith<$Res> {
  factory $MemberSourceCopyWith(
          MemberSource value, $Res Function(MemberSource) then) =
      _$MemberSourceCopyWithImpl<$Res, MemberSource>;
  @useResult
  $Res call({String joinReason, int count});
}

/// @nodoc
class _$MemberSourceCopyWithImpl<$Res, $Val extends MemberSource>
    implements $MemberSourceCopyWith<$Res> {
  _$MemberSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemberSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinReason = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      joinReason: null == joinReason
          ? _value.joinReason
          : joinReason // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MemberSourceImplCopyWith<$Res>
    implements $MemberSourceCopyWith<$Res> {
  factory _$$MemberSourceImplCopyWith(
          _$MemberSourceImpl value, $Res Function(_$MemberSourceImpl) then) =
      __$$MemberSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String joinReason, int count});
}

/// @nodoc
class __$$MemberSourceImplCopyWithImpl<$Res>
    extends _$MemberSourceCopyWithImpl<$Res, _$MemberSourceImpl>
    implements _$$MemberSourceImplCopyWith<$Res> {
  __$$MemberSourceImplCopyWithImpl(
      _$MemberSourceImpl _value, $Res Function(_$MemberSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MemberSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? joinReason = null,
    Object? count = null,
  }) {
    return _then(_$MemberSourceImpl(
      joinReason: null == joinReason
          ? _value.joinReason
          : joinReason // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MemberSourceImpl implements _MemberSource {
  const _$MemberSourceImpl({required this.joinReason, required this.count});

  factory _$MemberSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemberSourceImplFromJson(json);

  @override
  final String joinReason;
  @override
  final int count;

  @override
  String toString() {
    return 'MemberSource(joinReason: $joinReason, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemberSourceImpl &&
            (identical(other.joinReason, joinReason) ||
                other.joinReason == joinReason) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, joinReason, count);

  /// Create a copy of MemberSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemberSourceImplCopyWith<_$MemberSourceImpl> get copyWith =>
      __$$MemberSourceImplCopyWithImpl<_$MemberSourceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String joinReason, int count) $default,
  ) {
    return $default(joinReason, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String joinReason, int count)? $default,
  ) {
    return $default?.call(joinReason, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String joinReason, int count)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(joinReason, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MemberSource value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MemberSource value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MemberSource value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MemberSourceImplToJson(
      this,
    );
  }
}

abstract class _MemberSource implements MemberSource {
  const factory _MemberSource(
      {required final String joinReason,
      required final int count}) = _$MemberSourceImpl;

  factory _MemberSource.fromJson(Map<String, dynamic> json) =
      _$MemberSourceImpl.fromJson;

  @override
  String get joinReason;
  @override
  int get count;

  /// Create a copy of MemberSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemberSourceImplCopyWith<_$MemberSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvitationEffectiveness _$InvitationEffectivenessFromJson(
    Map<String, dynamic> json) {
  return _InvitationEffectiveness.fromJson(json);
}

/// @nodoc
mixin _$InvitationEffectiveness {
  String get source => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String source, String status, int count) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String source, String status, int count)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String source, String status, int count)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationEffectiveness value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationEffectiveness value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationEffectiveness value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationEffectiveness to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationEffectivenessCopyWith<InvitationEffectiveness> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationEffectivenessCopyWith<$Res> {
  factory $InvitationEffectivenessCopyWith(InvitationEffectiveness value,
          $Res Function(InvitationEffectiveness) then) =
      _$InvitationEffectivenessCopyWithImpl<$Res, InvitationEffectiveness>;
  @useResult
  $Res call({String source, String status, int count});
}

/// @nodoc
class _$InvitationEffectivenessCopyWithImpl<$Res,
        $Val extends InvitationEffectiveness>
    implements $InvitationEffectivenessCopyWith<$Res> {
  _$InvitationEffectivenessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? status = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationEffectivenessImplCopyWith<$Res>
    implements $InvitationEffectivenessCopyWith<$Res> {
  factory _$$InvitationEffectivenessImplCopyWith(
          _$InvitationEffectivenessImpl value,
          $Res Function(_$InvitationEffectivenessImpl) then) =
      __$$InvitationEffectivenessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String source, String status, int count});
}

/// @nodoc
class __$$InvitationEffectivenessImplCopyWithImpl<$Res>
    extends _$InvitationEffectivenessCopyWithImpl<$Res,
        _$InvitationEffectivenessImpl>
    implements _$$InvitationEffectivenessImplCopyWith<$Res> {
  __$$InvitationEffectivenessImplCopyWithImpl(
      _$InvitationEffectivenessImpl _value,
      $Res Function(_$InvitationEffectivenessImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? status = null,
    Object? count = null,
  }) {
    return _then(_$InvitationEffectivenessImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationEffectivenessImpl implements _InvitationEffectiveness {
  const _$InvitationEffectivenessImpl(
      {required this.source, required this.status, required this.count});

  factory _$InvitationEffectivenessImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationEffectivenessImplFromJson(json);

  @override
  final String source;
  @override
  final String status;
  @override
  final int count;

  @override
  String toString() {
    return 'InvitationEffectiveness(source: $source, status: $status, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationEffectivenessImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, source, status, count);

  /// Create a copy of InvitationEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationEffectivenessImplCopyWith<_$InvitationEffectivenessImpl>
      get copyWith => __$$InvitationEffectivenessImplCopyWithImpl<
          _$InvitationEffectivenessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String source, String status, int count) $default,
  ) {
    return $default(source, status, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String source, String status, int count)? $default,
  ) {
    return $default?.call(source, status, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String source, String status, int count)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(source, status, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationEffectiveness value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationEffectiveness value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationEffectiveness value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationEffectivenessImplToJson(
      this,
    );
  }
}

abstract class _InvitationEffectiveness implements InvitationEffectiveness {
  const factory _InvitationEffectiveness(
      {required final String source,
      required final String status,
      required final int count}) = _$InvitationEffectivenessImpl;

  factory _InvitationEffectiveness.fromJson(Map<String, dynamic> json) =
      _$InvitationEffectivenessImpl.fromJson;

  @override
  String get source;
  @override
  String get status;
  @override
  int get count;

  /// Create a copy of InvitationEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationEffectivenessImplCopyWith<_$InvitationEffectivenessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvitationDetailedAnalytics _$InvitationDetailedAnalyticsFromJson(
    Map<String, dynamic> json) {
  return _InvitationDetailedAnalytics.fromJson(json);
}

/// @nodoc
mixin _$InvitationDetailedAnalytics {
  InvitationAnalyticsData get invitation => throw _privateConstructorUsedError;
  AnalyticsSummary get summary => throw _privateConstructorUsedError;
  List<InvitationAnalytics> get recentEvents =>
      throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get joinRequests =>
      throw _privateConstructorUsedError;
  InvitationPerformanceMetrics get performance =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationDetailedAnalytics value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationDetailedAnalytics value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationDetailedAnalytics value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationDetailedAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationDetailedAnalyticsCopyWith<InvitationDetailedAnalytics>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationDetailedAnalyticsCopyWith<$Res> {
  factory $InvitationDetailedAnalyticsCopyWith(
          InvitationDetailedAnalytics value,
          $Res Function(InvitationDetailedAnalytics) then) =
      _$InvitationDetailedAnalyticsCopyWithImpl<$Res,
          InvitationDetailedAnalytics>;
  @useResult
  $Res call(
      {InvitationAnalyticsData invitation,
      AnalyticsSummary summary,
      List<InvitationAnalytics> recentEvents,
      List<Map<String, dynamic>> joinRequests,
      InvitationPerformanceMetrics performance});

  $InvitationAnalyticsDataCopyWith<$Res> get invitation;
  $AnalyticsSummaryCopyWith<$Res> get summary;
  $InvitationPerformanceMetricsCopyWith<$Res> get performance;
}

/// @nodoc
class _$InvitationDetailedAnalyticsCopyWithImpl<$Res,
        $Val extends InvitationDetailedAnalytics>
    implements $InvitationDetailedAnalyticsCopyWith<$Res> {
  _$InvitationDetailedAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitation = null,
    Object? summary = null,
    Object? recentEvents = null,
    Object? joinRequests = null,
    Object? performance = null,
  }) {
    return _then(_value.copyWith(
      invitation: null == invitation
          ? _value.invitation
          : invitation // ignore: cast_nullable_to_non_nullable
              as InvitationAnalyticsData,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as AnalyticsSummary,
      recentEvents: null == recentEvents
          ? _value.recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<InvitationAnalytics>,
      joinRequests: null == joinRequests
          ? _value.joinRequests
          : joinRequests // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      performance: null == performance
          ? _value.performance
          : performance // ignore: cast_nullable_to_non_nullable
              as InvitationPerformanceMetrics,
    ) as $Val);
  }

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvitationAnalyticsDataCopyWith<$Res> get invitation {
    return $InvitationAnalyticsDataCopyWith<$Res>(_value.invitation, (value) {
      return _then(_value.copyWith(invitation: value) as $Val);
    });
  }

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalyticsSummaryCopyWith<$Res> get summary {
    return $AnalyticsSummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvitationPerformanceMetricsCopyWith<$Res> get performance {
    return $InvitationPerformanceMetricsCopyWith<$Res>(_value.performance,
        (value) {
      return _then(_value.copyWith(performance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InvitationDetailedAnalyticsImplCopyWith<$Res>
    implements $InvitationDetailedAnalyticsCopyWith<$Res> {
  factory _$$InvitationDetailedAnalyticsImplCopyWith(
          _$InvitationDetailedAnalyticsImpl value,
          $Res Function(_$InvitationDetailedAnalyticsImpl) then) =
      __$$InvitationDetailedAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InvitationAnalyticsData invitation,
      AnalyticsSummary summary,
      List<InvitationAnalytics> recentEvents,
      List<Map<String, dynamic>> joinRequests,
      InvitationPerformanceMetrics performance});

  @override
  $InvitationAnalyticsDataCopyWith<$Res> get invitation;
  @override
  $AnalyticsSummaryCopyWith<$Res> get summary;
  @override
  $InvitationPerformanceMetricsCopyWith<$Res> get performance;
}

/// @nodoc
class __$$InvitationDetailedAnalyticsImplCopyWithImpl<$Res>
    extends _$InvitationDetailedAnalyticsCopyWithImpl<$Res,
        _$InvitationDetailedAnalyticsImpl>
    implements _$$InvitationDetailedAnalyticsImplCopyWith<$Res> {
  __$$InvitationDetailedAnalyticsImplCopyWithImpl(
      _$InvitationDetailedAnalyticsImpl _value,
      $Res Function(_$InvitationDetailedAnalyticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitation = null,
    Object? summary = null,
    Object? recentEvents = null,
    Object? joinRequests = null,
    Object? performance = null,
  }) {
    return _then(_$InvitationDetailedAnalyticsImpl(
      invitation: null == invitation
          ? _value.invitation
          : invitation // ignore: cast_nullable_to_non_nullable
              as InvitationAnalyticsData,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as AnalyticsSummary,
      recentEvents: null == recentEvents
          ? _value._recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<InvitationAnalytics>,
      joinRequests: null == joinRequests
          ? _value._joinRequests
          : joinRequests // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      performance: null == performance
          ? _value.performance
          : performance // ignore: cast_nullable_to_non_nullable
              as InvitationPerformanceMetrics,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationDetailedAnalyticsImpl
    implements _InvitationDetailedAnalytics {
  const _$InvitationDetailedAnalyticsImpl(
      {required this.invitation,
      required this.summary,
      required final List<InvitationAnalytics> recentEvents,
      required final List<Map<String, dynamic>> joinRequests,
      required this.performance})
      : _recentEvents = recentEvents,
        _joinRequests = joinRequests;

  factory _$InvitationDetailedAnalyticsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InvitationDetailedAnalyticsImplFromJson(json);

  @override
  final InvitationAnalyticsData invitation;
  @override
  final AnalyticsSummary summary;
  final List<InvitationAnalytics> _recentEvents;
  @override
  List<InvitationAnalytics> get recentEvents {
    if (_recentEvents is EqualUnmodifiableListView) return _recentEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentEvents);
  }

  final List<Map<String, dynamic>> _joinRequests;
  @override
  List<Map<String, dynamic>> get joinRequests {
    if (_joinRequests is EqualUnmodifiableListView) return _joinRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinRequests);
  }

  @override
  final InvitationPerformanceMetrics performance;

  @override
  String toString() {
    return 'InvitationDetailedAnalytics(invitation: $invitation, summary: $summary, recentEvents: $recentEvents, joinRequests: $joinRequests, performance: $performance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationDetailedAnalyticsImpl &&
            (identical(other.invitation, invitation) ||
                other.invitation == invitation) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality()
                .equals(other._recentEvents, _recentEvents) &&
            const DeepCollectionEquality()
                .equals(other._joinRequests, _joinRequests) &&
            (identical(other.performance, performance) ||
                other.performance == performance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      invitation,
      summary,
      const DeepCollectionEquality().hash(_recentEvents),
      const DeepCollectionEquality().hash(_joinRequests),
      performance);

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationDetailedAnalyticsImplCopyWith<_$InvitationDetailedAnalyticsImpl>
      get copyWith => __$$InvitationDetailedAnalyticsImplCopyWithImpl<
          _$InvitationDetailedAnalyticsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)
        $default,
  ) {
    return $default(
        invitation, summary, recentEvents, joinRequests, performance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)?
        $default,
  ) {
    return $default?.call(
        invitation, summary, recentEvents, joinRequests, performance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            InvitationAnalyticsData invitation,
            AnalyticsSummary summary,
            List<InvitationAnalytics> recentEvents,
            List<Map<String, dynamic>> joinRequests,
            InvitationPerformanceMetrics performance)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          invitation, summary, recentEvents, joinRequests, performance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationDetailedAnalytics value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationDetailedAnalytics value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationDetailedAnalytics value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationDetailedAnalyticsImplToJson(
      this,
    );
  }
}

abstract class _InvitationDetailedAnalytics
    implements InvitationDetailedAnalytics {
  const factory _InvitationDetailedAnalytics(
          {required final InvitationAnalyticsData invitation,
          required final AnalyticsSummary summary,
          required final List<InvitationAnalytics> recentEvents,
          required final List<Map<String, dynamic>> joinRequests,
          required final InvitationPerformanceMetrics performance}) =
      _$InvitationDetailedAnalyticsImpl;

  factory _InvitationDetailedAnalytics.fromJson(Map<String, dynamic> json) =
      _$InvitationDetailedAnalyticsImpl.fromJson;

  @override
  InvitationAnalyticsData get invitation;
  @override
  AnalyticsSummary get summary;
  @override
  List<InvitationAnalytics> get recentEvents;
  @override
  List<Map<String, dynamic>> get joinRequests;
  @override
  InvitationPerformanceMetrics get performance;

  /// Create a copy of InvitationDetailedAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationDetailedAnalyticsImplCopyWith<_$InvitationDetailedAnalyticsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvitationAnalyticsData _$InvitationAnalyticsDataFromJson(
    Map<String, dynamic> json) {
  return _InvitationAnalyticsData.fromJson(json);
}

/// @nodoc
mixin _$InvitationAnalyticsData {
  int get id => throw _privateConstructorUsedError;
  int get groupId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationAnalyticsData value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationAnalyticsData value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationAnalyticsData value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationAnalyticsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationAnalyticsDataCopyWith<InvitationAnalyticsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationAnalyticsDataCopyWith<$Res> {
  factory $InvitationAnalyticsDataCopyWith(InvitationAnalyticsData value,
          $Res Function(InvitationAnalyticsData) then) =
      _$InvitationAnalyticsDataCopyWithImpl<$Res, InvitationAnalyticsData>;
  @useResult
  $Res call(
      {int id,
      int groupId,
      String token,
      String type,
      String status,
      DateTime? expiresAt,
      DateTime createdAt});
}

/// @nodoc
class _$InvitationAnalyticsDataCopyWithImpl<$Res,
        $Val extends InvitationAnalyticsData>
    implements $InvitationAnalyticsDataCopyWith<$Res> {
  _$InvitationAnalyticsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? token = null,
    Object? type = null,
    Object? status = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationAnalyticsDataImplCopyWith<$Res>
    implements $InvitationAnalyticsDataCopyWith<$Res> {
  factory _$$InvitationAnalyticsDataImplCopyWith(
          _$InvitationAnalyticsDataImpl value,
          $Res Function(_$InvitationAnalyticsDataImpl) then) =
      __$$InvitationAnalyticsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int groupId,
      String token,
      String type,
      String status,
      DateTime? expiresAt,
      DateTime createdAt});
}

/// @nodoc
class __$$InvitationAnalyticsDataImplCopyWithImpl<$Res>
    extends _$InvitationAnalyticsDataCopyWithImpl<$Res,
        _$InvitationAnalyticsDataImpl>
    implements _$$InvitationAnalyticsDataImplCopyWith<$Res> {
  __$$InvitationAnalyticsDataImplCopyWithImpl(
      _$InvitationAnalyticsDataImpl _value,
      $Res Function(_$InvitationAnalyticsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? token = null,
    Object? type = null,
    Object? status = null,
    Object? expiresAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$InvitationAnalyticsDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationAnalyticsDataImpl implements _InvitationAnalyticsData {
  const _$InvitationAnalyticsDataImpl(
      {required this.id,
      required this.groupId,
      required this.token,
      required this.type,
      required this.status,
      this.expiresAt,
      required this.createdAt});

  factory _$InvitationAnalyticsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationAnalyticsDataImplFromJson(json);

  @override
  final int id;
  @override
  final int groupId;
  @override
  final String token;
  @override
  final String type;
  @override
  final String status;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'InvitationAnalyticsData(id: $id, groupId: $groupId, token: $token, type: $type, status: $status, expiresAt: $expiresAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationAnalyticsDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, groupId, token, type, status, expiresAt, createdAt);

  /// Create a copy of InvitationAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationAnalyticsDataImplCopyWith<_$InvitationAnalyticsDataImpl>
      get copyWith => __$$InvitationAnalyticsDataImplCopyWithImpl<
          _$InvitationAnalyticsDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)
        $default,
  ) {
    return $default(id, groupId, token, type, status, expiresAt, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)?
        $default,
  ) {
    return $default?.call(
        id, groupId, token, type, status, expiresAt, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, int groupId, String token, String type,
            String status, DateTime? expiresAt, DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(id, groupId, token, type, status, expiresAt, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationAnalyticsData value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationAnalyticsData value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationAnalyticsData value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationAnalyticsDataImplToJson(
      this,
    );
  }
}

abstract class _InvitationAnalyticsData implements InvitationAnalyticsData {
  const factory _InvitationAnalyticsData(
      {required final int id,
      required final int groupId,
      required final String token,
      required final String type,
      required final String status,
      final DateTime? expiresAt,
      required final DateTime createdAt}) = _$InvitationAnalyticsDataImpl;

  factory _InvitationAnalyticsData.fromJson(Map<String, dynamic> json) =
      _$InvitationAnalyticsDataImpl.fromJson;

  @override
  int get id;
  @override
  int get groupId;
  @override
  String get token;
  @override
  String get type;
  @override
  String get status;
  @override
  DateTime? get expiresAt;
  @override
  DateTime get createdAt;

  /// Create a copy of InvitationAnalyticsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationAnalyticsDataImplCopyWith<_$InvitationAnalyticsDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InvitationPerformanceMetrics _$InvitationPerformanceMetricsFromJson(
    Map<String, dynamic> json) {
  return _InvitationPerformanceMetrics.fromJson(json);
}

/// @nodoc
mixin _$InvitationPerformanceMetrics {
  String get clickRate => throw _privateConstructorUsedError;
  String get conversionRate => throw _privateConstructorUsedError;
  int get totalClicks => throw _privateConstructorUsedError;
  int get totalJoins => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationPerformanceMetrics value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationPerformanceMetrics value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationPerformanceMetrics value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this InvitationPerformanceMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationPerformanceMetricsCopyWith<InvitationPerformanceMetrics>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationPerformanceMetricsCopyWith<$Res> {
  factory $InvitationPerformanceMetricsCopyWith(
          InvitationPerformanceMetrics value,
          $Res Function(InvitationPerformanceMetrics) then) =
      _$InvitationPerformanceMetricsCopyWithImpl<$Res,
          InvitationPerformanceMetrics>;
  @useResult
  $Res call(
      {String clickRate,
      String conversionRate,
      int totalClicks,
      int totalJoins});
}

/// @nodoc
class _$InvitationPerformanceMetricsCopyWithImpl<$Res,
        $Val extends InvitationPerformanceMetrics>
    implements $InvitationPerformanceMetricsCopyWith<$Res> {
  _$InvitationPerformanceMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickRate = null,
    Object? conversionRate = null,
    Object? totalClicks = null,
    Object? totalJoins = null,
  }) {
    return _then(_value.copyWith(
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as String,
      totalClicks: null == totalClicks
          ? _value.totalClicks
          : totalClicks // ignore: cast_nullable_to_non_nullable
              as int,
      totalJoins: null == totalJoins
          ? _value.totalJoins
          : totalJoins // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationPerformanceMetricsImplCopyWith<$Res>
    implements $InvitationPerformanceMetricsCopyWith<$Res> {
  factory _$$InvitationPerformanceMetricsImplCopyWith(
          _$InvitationPerformanceMetricsImpl value,
          $Res Function(_$InvitationPerformanceMetricsImpl) then) =
      __$$InvitationPerformanceMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clickRate,
      String conversionRate,
      int totalClicks,
      int totalJoins});
}

/// @nodoc
class __$$InvitationPerformanceMetricsImplCopyWithImpl<$Res>
    extends _$InvitationPerformanceMetricsCopyWithImpl<$Res,
        _$InvitationPerformanceMetricsImpl>
    implements _$$InvitationPerformanceMetricsImplCopyWith<$Res> {
  __$$InvitationPerformanceMetricsImplCopyWithImpl(
      _$InvitationPerformanceMetricsImpl _value,
      $Res Function(_$InvitationPerformanceMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickRate = null,
    Object? conversionRate = null,
    Object? totalClicks = null,
    Object? totalJoins = null,
  }) {
    return _then(_$InvitationPerformanceMetricsImpl(
      clickRate: null == clickRate
          ? _value.clickRate
          : clickRate // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as String,
      totalClicks: null == totalClicks
          ? _value.totalClicks
          : totalClicks // ignore: cast_nullable_to_non_nullable
              as int,
      totalJoins: null == totalJoins
          ? _value.totalJoins
          : totalJoins // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationPerformanceMetricsImpl
    implements _InvitationPerformanceMetrics {
  const _$InvitationPerformanceMetricsImpl(
      {required this.clickRate,
      required this.conversionRate,
      required this.totalClicks,
      required this.totalJoins});

  factory _$InvitationPerformanceMetricsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InvitationPerformanceMetricsImplFromJson(json);

  @override
  final String clickRate;
  @override
  final String conversionRate;
  @override
  final int totalClicks;
  @override
  final int totalJoins;

  @override
  String toString() {
    return 'InvitationPerformanceMetrics(clickRate: $clickRate, conversionRate: $conversionRate, totalClicks: $totalClicks, totalJoins: $totalJoins)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationPerformanceMetricsImpl &&
            (identical(other.clickRate, clickRate) ||
                other.clickRate == clickRate) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate) &&
            (identical(other.totalClicks, totalClicks) ||
                other.totalClicks == totalClicks) &&
            (identical(other.totalJoins, totalJoins) ||
                other.totalJoins == totalJoins));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, clickRate, conversionRate, totalClicks, totalJoins);

  /// Create a copy of InvitationPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationPerformanceMetricsImplCopyWith<
          _$InvitationPerformanceMetricsImpl>
      get copyWith => __$$InvitationPerformanceMetricsImplCopyWithImpl<
          _$InvitationPerformanceMetricsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)
        $default,
  ) {
    return $default(clickRate, conversionRate, totalClicks, totalJoins);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)?
        $default,
  ) {
    return $default?.call(clickRate, conversionRate, totalClicks, totalJoins);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String clickRate, String conversionRate, int totalClicks,
            int totalJoins)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(clickRate, conversionRate, totalClicks, totalJoins);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationPerformanceMetrics value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationPerformanceMetrics value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationPerformanceMetrics value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationPerformanceMetricsImplToJson(
      this,
    );
  }
}

abstract class _InvitationPerformanceMetrics
    implements InvitationPerformanceMetrics {
  const factory _InvitationPerformanceMetrics(
      {required final String clickRate,
      required final String conversionRate,
      required final int totalClicks,
      required final int totalJoins}) = _$InvitationPerformanceMetricsImpl;

  factory _InvitationPerformanceMetrics.fromJson(Map<String, dynamic> json) =
      _$InvitationPerformanceMetricsImpl.fromJson;

  @override
  String get clickRate;
  @override
  String get conversionRate;
  @override
  int get totalClicks;
  @override
  int get totalJoins;

  /// Create a copy of InvitationPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationPerformanceMetricsImplCopyWith<
          _$InvitationPerformanceMetricsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl implements _Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$AuthenticatingImplCopyWith<$Res> {
  factory _$$AuthenticatingImplCopyWith(_$AuthenticatingImpl value,
          $Res Function(_$AuthenticatingImpl) then) =
      __$$AuthenticatingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$AuthenticatingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatingImpl>
    implements _$$AuthenticatingImplCopyWith<$Res> {
  __$$AuthenticatingImplCopyWithImpl(
      _$AuthenticatingImpl _value, $Res Function(_$AuthenticatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$AuthenticatingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthenticatingImpl implements _Authenticating {
  const _$AuthenticatingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthState.authenticating(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatingImplCopyWith<_$AuthenticatingImpl> get copyWith =>
      __$$AuthenticatingImplCopyWithImpl<_$AuthenticatingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return authenticating(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return authenticating?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return authenticating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return authenticating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (authenticating != null) {
      return authenticating(this);
    }
    return orElse();
  }
}

abstract class _Authenticating implements AuthState {
  const factory _Authenticating({final String? message}) = _$AuthenticatingImpl;

  String? get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatingImplCopyWith<_$AuthenticatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user, AuthTokens tokens});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? tokens = null,
  }) {
    return _then(_$AuthenticatedImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl({required this.user, required this.tokens});

  @override
  final UserModel user;
  @override
  final AuthTokens tokens;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return authenticated(user, tokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return authenticated?.call(user, tokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user, tokens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated(
      {required final UserModel user,
      required final AuthTokens tokens}) = _$AuthenticatedImpl;

  UserModel get user;
  AuthTokens get tokens;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneVerificationRequiredImplCopyWith<$Res> {
  factory _$$PhoneVerificationRequiredImplCopyWith(
          _$PhoneVerificationRequiredImpl value,
          $Res Function(_$PhoneVerificationRequiredImpl) then) =
      __$$PhoneVerificationRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber, String? verificationId});
}

/// @nodoc
class __$$PhoneVerificationRequiredImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$PhoneVerificationRequiredImpl>
    implements _$$PhoneVerificationRequiredImplCopyWith<$Res> {
  __$$PhoneVerificationRequiredImplCopyWithImpl(
      _$PhoneVerificationRequiredImpl _value,
      $Res Function(_$PhoneVerificationRequiredImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? verificationId = freezed,
  }) {
    return _then(_$PhoneVerificationRequiredImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: freezed == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PhoneVerificationRequiredImpl implements _PhoneVerificationRequired {
  const _$PhoneVerificationRequiredImpl(
      {required this.phoneNumber, this.verificationId});

  @override
  final String phoneNumber;
  @override
  final String? verificationId;

  @override
  String toString() {
    return 'AuthState.phoneVerificationRequired(phoneNumber: $phoneNumber, verificationId: $verificationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneVerificationRequiredImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, verificationId);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneVerificationRequiredImplCopyWith<_$PhoneVerificationRequiredImpl>
      get copyWith => __$$PhoneVerificationRequiredImplCopyWithImpl<
          _$PhoneVerificationRequiredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return phoneVerificationRequired(phoneNumber, verificationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return phoneVerificationRequired?.call(phoneNumber, verificationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (phoneVerificationRequired != null) {
      return phoneVerificationRequired(phoneNumber, verificationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return phoneVerificationRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return phoneVerificationRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (phoneVerificationRequired != null) {
      return phoneVerificationRequired(this);
    }
    return orElse();
  }
}

abstract class _PhoneVerificationRequired implements AuthState {
  const factory _PhoneVerificationRequired(
      {required final String phoneNumber,
      final String? verificationId}) = _$PhoneVerificationRequiredImpl;

  String get phoneNumber;
  String? get verificationId;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneVerificationRequiredImplCopyWith<_$PhoneVerificationRequiredImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? errorCode});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$AuthErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements _AuthError {
  const _$AuthErrorImpl({required this.message, this.errorCode});

  @override
  final String message;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'AuthState.error(message: $message, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorCode);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return error(message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return error?.call(message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthError implements AuthState {
  const factory _AuthError(
      {required final String message,
      final String? errorCode}) = _$AuthErrorImpl;

  String get message;
  String? get errorCode;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshingTokenImplCopyWith<$Res> {
  factory _$$RefreshingTokenImplCopyWith(_$RefreshingTokenImpl value,
          $Res Function(_$RefreshingTokenImpl) then) =
      __$$RefreshingTokenImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel user, AuthTokens tokens});
}

/// @nodoc
class __$$RefreshingTokenImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RefreshingTokenImpl>
    implements _$$RefreshingTokenImplCopyWith<$Res> {
  __$$RefreshingTokenImplCopyWithImpl(
      _$RefreshingTokenImpl _value, $Res Function(_$RefreshingTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? tokens = null,
  }) {
    return _then(_$RefreshingTokenImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as AuthTokens,
    ));
  }
}

/// @nodoc

class _$RefreshingTokenImpl implements _RefreshingToken {
  const _$RefreshingTokenImpl({required this.user, required this.tokens});

  @override
  final UserModel user;
  @override
  final AuthTokens tokens;

  @override
  String toString() {
    return 'AuthState.refreshingToken(user: $user, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshingTokenImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.tokens, tokens) || other.tokens == tokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, tokens);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshingTokenImplCopyWith<_$RefreshingTokenImpl> get copyWith =>
      __$$RefreshingTokenImplCopyWithImpl<_$RefreshingTokenImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthenticated,
    required TResult Function(String? message) authenticating,
    required TResult Function(UserModel user, AuthTokens tokens) authenticated,
    required TResult Function(String phoneNumber, String? verificationId)
        phoneVerificationRequired,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function(UserModel user, AuthTokens tokens)
        refreshingToken,
  }) {
    return refreshingToken(user, tokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthenticated,
    TResult? Function(String? message)? authenticating,
    TResult? Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult? Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function(UserModel user, AuthTokens tokens)? refreshingToken,
  }) {
    return refreshingToken?.call(user, tokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthenticated,
    TResult Function(String? message)? authenticating,
    TResult Function(UserModel user, AuthTokens tokens)? authenticated,
    TResult Function(String phoneNumber, String? verificationId)?
        phoneVerificationRequired,
    TResult Function(String message, String? errorCode)? error,
    TResult Function(UserModel user, AuthTokens tokens)? refreshingToken,
    required TResult orElse(),
  }) {
    if (refreshingToken != null) {
      return refreshingToken(user, tokens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticating value) authenticating,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PhoneVerificationRequired value)
        phoneVerificationRequired,
    required TResult Function(_AuthError value) error,
    required TResult Function(_RefreshingToken value) refreshingToken,
  }) {
    return refreshingToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticating value)? authenticating,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult? Function(_AuthError value)? error,
    TResult? Function(_RefreshingToken value)? refreshingToken,
  }) {
    return refreshingToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticating value)? authenticating,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PhoneVerificationRequired value)?
        phoneVerificationRequired,
    TResult Function(_AuthError value)? error,
    TResult Function(_RefreshingToken value)? refreshingToken,
    required TResult orElse(),
  }) {
    if (refreshingToken != null) {
      return refreshingToken(this);
    }
    return orElse();
  }
}

abstract class _RefreshingToken implements AuthState {
  const factory _RefreshingToken(
      {required final UserModel user,
      required final AuthTokens tokens}) = _$RefreshingTokenImpl;

  UserModel get user;
  AuthTokens get tokens;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshingTokenImplCopyWith<_$RefreshingTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

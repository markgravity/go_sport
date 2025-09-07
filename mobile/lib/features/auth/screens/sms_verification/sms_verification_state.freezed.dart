// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SmsVerificationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsVerificationStateCopyWith<$Res> {
  factory $SmsVerificationStateCopyWith(SmsVerificationState value,
          $Res Function(SmsVerificationState) then) =
      _$SmsVerificationStateCopyWithImpl<$Res, SmsVerificationState>;
}

/// @nodoc
class _$SmsVerificationStateCopyWithImpl<$Res,
        $Val extends SmsVerificationState>
    implements $SmsVerificationStateCopyWith<$Res> {
  _$SmsVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SmsVerificationState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SmsVerificationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'SmsVerificationState.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SmsVerificationState {
  const factory _Loading({final String? message}) = _$LoadingImpl;

  String? get message;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaitingForCodeImplCopyWith<$Res> {
  factory _$$WaitingForCodeImplCopyWith(_$WaitingForCodeImpl value,
          $Res Function(_$WaitingForCodeImpl) then) =
      __$$WaitingForCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String phoneNumber,
      String verificationId,
      int resendCountdown,
      String? currentCode,
      String? userName,
      String? userPassword,
      List<String>? preferredSports});
}

/// @nodoc
class __$$WaitingForCodeImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$WaitingForCodeImpl>
    implements _$$WaitingForCodeImplCopyWith<$Res> {
  __$$WaitingForCodeImplCopyWithImpl(
      _$WaitingForCodeImpl _value, $Res Function(_$WaitingForCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? verificationId = null,
    Object? resendCountdown = null,
    Object? currentCode = freezed,
    Object? userName = freezed,
    Object? userPassword = freezed,
    Object? preferredSports = freezed,
  }) {
    return _then(_$WaitingForCodeImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendCountdown: null == resendCountdown
          ? _value.resendCountdown
          : resendCountdown // ignore: cast_nullable_to_non_nullable
              as int,
      currentCode: freezed == currentCode
          ? _value.currentCode
          : currentCode // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userPassword: freezed == userPassword
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      preferredSports: freezed == preferredSports
          ? _value._preferredSports
          : preferredSports // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$WaitingForCodeImpl implements _WaitingForCode {
  const _$WaitingForCodeImpl(
      {required this.phoneNumber,
      required this.verificationId,
      required this.resendCountdown,
      this.currentCode,
      this.userName,
      this.userPassword,
      final List<String>? preferredSports})
      : _preferredSports = preferredSports;

  @override
  final String phoneNumber;
  @override
  final String verificationId;
  @override
  final int resendCountdown;
  @override
  final String? currentCode;
  @override
  final String? userName;
  @override
  final String? userPassword;
  final List<String>? _preferredSports;
  @override
  List<String>? get preferredSports {
    final value = _preferredSports;
    if (value == null) return null;
    if (_preferredSports is EqualUnmodifiableListView) return _preferredSports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SmsVerificationState.waitingForCode(phoneNumber: $phoneNumber, verificationId: $verificationId, resendCountdown: $resendCountdown, currentCode: $currentCode, userName: $userName, userPassword: $userPassword, preferredSports: $preferredSports)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaitingForCodeImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendCountdown, resendCountdown) ||
                other.resendCountdown == resendCountdown) &&
            (identical(other.currentCode, currentCode) ||
                other.currentCode == currentCode) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPassword, userPassword) ||
                other.userPassword == userPassword) &&
            const DeepCollectionEquality()
                .equals(other._preferredSports, _preferredSports));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      phoneNumber,
      verificationId,
      resendCountdown,
      currentCode,
      userName,
      userPassword,
      const DeepCollectionEquality().hash(_preferredSports));

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WaitingForCodeImplCopyWith<_$WaitingForCodeImpl> get copyWith =>
      __$$WaitingForCodeImplCopyWithImpl<_$WaitingForCodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return waitingForCode(phoneNumber, verificationId, resendCountdown,
        currentCode, userName, userPassword, preferredSports);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return waitingForCode?.call(phoneNumber, verificationId, resendCountdown,
        currentCode, userName, userPassword, preferredSports);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (waitingForCode != null) {
      return waitingForCode(phoneNumber, verificationId, resendCountdown,
          currentCode, userName, userPassword, preferredSports);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return waitingForCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return waitingForCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (waitingForCode != null) {
      return waitingForCode(this);
    }
    return orElse();
  }
}

abstract class _WaitingForCode implements SmsVerificationState {
  const factory _WaitingForCode(
      {required final String phoneNumber,
      required final String verificationId,
      required final int resendCountdown,
      final String? currentCode,
      final String? userName,
      final String? userPassword,
      final List<String>? preferredSports}) = _$WaitingForCodeImpl;

  String get phoneNumber;
  String get verificationId;
  int get resendCountdown;
  String? get currentCode;
  String? get userName;
  String? get userPassword;
  List<String>? get preferredSports;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WaitingForCodeImplCopyWith<_$WaitingForCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CodeResentImplCopyWith<$Res> {
  factory _$$CodeResentImplCopyWith(
          _$CodeResentImpl value, $Res Function(_$CodeResentImpl) then) =
      __$$CodeResentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber, String verificationId, int resendCountdown});
}

/// @nodoc
class __$$CodeResentImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$CodeResentImpl>
    implements _$$CodeResentImplCopyWith<$Res> {
  __$$CodeResentImplCopyWithImpl(
      _$CodeResentImpl _value, $Res Function(_$CodeResentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? verificationId = null,
    Object? resendCountdown = null,
  }) {
    return _then(_$CodeResentImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendCountdown: null == resendCountdown
          ? _value.resendCountdown
          : resendCountdown // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CodeResentImpl implements _CodeResent {
  const _$CodeResentImpl(
      {required this.phoneNumber,
      required this.verificationId,
      required this.resendCountdown});

  @override
  final String phoneNumber;
  @override
  final String verificationId;
  @override
  final int resendCountdown;

  @override
  String toString() {
    return 'SmsVerificationState.codeResent(phoneNumber: $phoneNumber, verificationId: $verificationId, resendCountdown: $resendCountdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeResentImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendCountdown, resendCountdown) ||
                other.resendCountdown == resendCountdown));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, verificationId, resendCountdown);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeResentImplCopyWith<_$CodeResentImpl> get copyWith =>
      __$$CodeResentImplCopyWithImpl<_$CodeResentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return codeResent(phoneNumber, verificationId, resendCountdown);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return codeResent?.call(phoneNumber, verificationId, resendCountdown);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (codeResent != null) {
      return codeResent(phoneNumber, verificationId, resendCountdown);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return codeResent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return codeResent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (codeResent != null) {
      return codeResent(this);
    }
    return orElse();
  }
}

abstract class _CodeResent implements SmsVerificationState {
  const factory _CodeResent(
      {required final String phoneNumber,
      required final String verificationId,
      required final int resendCountdown}) = _$CodeResentImpl;

  String get phoneNumber;
  String get verificationId;
  int get resendCountdown;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeResentImplCopyWith<_$CodeResentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message, bool isRegistration});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? isRegistration = null,
  }) {
    return _then(_$SuccessImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistration: null == isRegistration
          ? _value.isRegistration
          : isRegistration // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl({this.message, required this.isRegistration});

  @override
  final String? message;
  @override
  final bool isRegistration;

  @override
  String toString() {
    return 'SmsVerificationState.success(message: $message, isRegistration: $isRegistration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isRegistration, isRegistration) ||
                other.isRegistration == isRegistration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, isRegistration);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return success(message, isRegistration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return success?.call(message, isRegistration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, isRegistration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements SmsVerificationState {
  const factory _Success(
      {final String? message,
      required final bool isRegistration}) = _$SuccessImpl;

  String? get message;
  bool get isRegistration;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String? errorCode});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$ErrorImpl(
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

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message, this.errorCode});

  @override
  final String message;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'SmsVerificationState.error(message: $message, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, errorCode);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return error(message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return error?.call(message, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SmsVerificationState {
  const factory _Error(
      {required final String message, final String? errorCode}) = _$ErrorImpl;

  String get message;
  String? get errorCode;

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NavigateBackImplCopyWith<$Res> {
  factory _$$NavigateBackImplCopyWith(
          _$NavigateBackImpl value, $Res Function(_$NavigateBackImpl) then) =
      __$$NavigateBackImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NavigateBackImplCopyWithImpl<$Res>
    extends _$SmsVerificationStateCopyWithImpl<$Res, _$NavigateBackImpl>
    implements _$$NavigateBackImplCopyWith<$Res> {
  __$$NavigateBackImplCopyWithImpl(
      _$NavigateBackImpl _value, $Res Function(_$NavigateBackImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmsVerificationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NavigateBackImpl implements _NavigateBack {
  const _$NavigateBackImpl();

  @override
  String toString() {
    return 'SmsVerificationState.navigateBack()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NavigateBackImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)
        waitingForCode,
    required TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)
        codeResent,
    required TResult Function(String? message, bool isRegistration) success,
    required TResult Function(String message, String? errorCode) error,
    required TResult Function() navigateBack,
  }) {
    return navigateBack();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult? Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult? Function(String? message, bool isRegistration)? success,
    TResult? Function(String message, String? errorCode)? error,
    TResult? Function()? navigateBack,
  }) {
    return navigateBack?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            String phoneNumber,
            String verificationId,
            int resendCountdown,
            String? currentCode,
            String? userName,
            String? userPassword,
            List<String>? preferredSports)?
        waitingForCode,
    TResult Function(
            String phoneNumber, String verificationId, int resendCountdown)?
        codeResent,
    TResult Function(String? message, bool isRegistration)? success,
    TResult Function(String message, String? errorCode)? error,
    TResult Function()? navigateBack,
    required TResult orElse(),
  }) {
    if (navigateBack != null) {
      return navigateBack();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_WaitingForCode value) waitingForCode,
    required TResult Function(_CodeResent value) codeResent,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
    required TResult Function(_NavigateBack value) navigateBack,
  }) {
    return navigateBack(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_WaitingForCode value)? waitingForCode,
    TResult? Function(_CodeResent value)? codeResent,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
    TResult? Function(_NavigateBack value)? navigateBack,
  }) {
    return navigateBack?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_WaitingForCode value)? waitingForCode,
    TResult Function(_CodeResent value)? codeResent,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    TResult Function(_NavigateBack value)? navigateBack,
    required TResult orElse(),
  }) {
    if (navigateBack != null) {
      return navigateBack(this);
    }
    return orElse();
  }
}

abstract class _NavigateBack implements SmsVerificationState {
  const factory _NavigateBack() = _$NavigateBackImpl;
}

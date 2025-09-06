// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BaseState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(T data, String? message) success,
    required TResult Function(String message, Object? exception) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(T data, String? message)? success,
    TResult? Function(String message, Object? exception)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(T data, String? message)? success,
    TResult Function(String message, Object? exception)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseStateCopyWith<T, $Res> {
  factory $BaseStateCopyWith(
          BaseState<T> value, $Res Function(BaseState<T>) then) =
      _$BaseStateCopyWithImpl<T, $Res, BaseState<T>>;
}

/// @nodoc
class _$BaseStateCopyWithImpl<T, $Res, $Val extends BaseState<T>>
    implements $BaseStateCopyWith<T, $Res> {
  _$BaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'BaseState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(T data, String? message) success,
    required TResult Function(String message, Object? exception) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(T data, String? message)? success,
    TResult? Function(String message, Object? exception)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(T data, String? message)? success,
    TResult Function(String message, Object? exception)? error,
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
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements BaseState<T> {
  const factory _Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LoadingImpl<T>(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl<T> implements _Loading<T> {
  const _$LoadingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'BaseState<$T>.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      __$$LoadingImplCopyWithImpl<T, _$LoadingImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(T data, String? message) success,
    required TResult Function(String message, Object? exception) error,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(T data, String? message)? success,
    TResult? Function(String message, Object? exception)? error,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(T data, String? message)? success,
    TResult Function(String message, Object? exception)? error,
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
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> implements BaseState<T> {
  const factory _Loading({final String? message}) = _$LoadingImpl<T>;

  String? get message;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data, String? message});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? message = freezed,
  }) {
    return _then(_$SuccessImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl<T> implements _Success<T> {
  const _$SuccessImpl({required this.data, this.message});

  @override
  final T data;
  @override
  final String? message;

  @override
  String toString() {
    return 'BaseState<$T>.success(data: $data, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), message);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(T data, String? message) success,
    required TResult Function(String message, Object? exception) error,
  }) {
    return success(data, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(T data, String? message)? success,
    TResult? Function(String message, Object? exception)? error,
  }) {
    return success?.call(data, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(T data, String? message)? success,
    TResult Function(String message, Object? exception)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<T> implements BaseState<T> {
  const factory _Success({required final T data, final String? message}) =
      _$SuccessImpl<T>;

  T get data;
  String? get message;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, Object? exception});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$BaseStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? exception = freezed,
  }) {
    return _then(_$ErrorImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      exception: freezed == exception ? _value.exception : exception,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements _Error<T> {
  const _$ErrorImpl({required this.message, this.exception});

  @override
  final String message;
  @override
  final Object? exception;

  @override
  String toString() {
    return 'BaseState<$T>.error(message: $message, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(exception));

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(T data, String? message) success,
    required TResult Function(String message, Object? exception) error,
  }) {
    return error(message, exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(T data, String? message)? success,
    TResult? Function(String message, Object? exception)? error,
  }) {
    return error?.call(message, exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(T data, String? message)? success,
    TResult Function(String message, Object? exception)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Success<T> value) success,
    required TResult Function(_Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Success<T> value)? success,
    TResult? Function(_Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Success<T> value)? success,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements BaseState<T> {
  const factory _Error(
      {required final String message,
      final Object? exception}) = _$ErrorImpl<T>;

  String get message;
  Object? get exception;

  /// Create a copy of BaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ListState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListStateCopyWith<T, $Res> {
  factory $ListStateCopyWith(
          ListState<T> value, $Res Function(ListState<T>) then) =
      _$ListStateCopyWithImpl<T, $Res, ListState<T>>;
}

/// @nodoc
class _$ListStateCopyWithImpl<T, $Res, $Val extends ListState<T>>
    implements $ListStateCopyWith<T, $Res> {
  _$ListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ListInitialImplCopyWith<T, $Res> {
  factory _$$ListInitialImplCopyWith(_$ListInitialImpl<T> value,
          $Res Function(_$ListInitialImpl<T>) then) =
      __$$ListInitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ListInitialImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListInitialImpl<T>>
    implements _$$ListInitialImplCopyWith<T, $Res> {
  __$$ListInitialImplCopyWithImpl(
      _$ListInitialImpl<T> _value, $Res Function(_$ListInitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ListInitialImpl<T> implements _ListInitial<T> {
  const _$ListInitialImpl();

  @override
  String toString() {
    return 'ListState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ListInitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
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
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ListInitial<T> implements ListState<T> {
  const factory _ListInitial() = _$ListInitialImpl<T>;
}

/// @nodoc
abstract class _$$ListLoadingImplCopyWith<T, $Res> {
  factory _$$ListLoadingImplCopyWith(_$ListLoadingImpl<T> value,
          $Res Function(_$ListLoadingImpl<T>) then) =
      __$$ListLoadingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T>? currentData, String? message});
}

/// @nodoc
class __$$ListLoadingImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListLoadingImpl<T>>
    implements _$$ListLoadingImplCopyWith<T, $Res> {
  __$$ListLoadingImplCopyWithImpl(
      _$ListLoadingImpl<T> _value, $Res Function(_$ListLoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentData = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ListLoadingImpl<T>(
      currentData: freezed == currentData
          ? _value._currentData
          : currentData // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ListLoadingImpl<T> implements _ListLoading<T> {
  const _$ListLoadingImpl({final List<T>? currentData, this.message})
      : _currentData = currentData;

  final List<T>? _currentData;
  @override
  List<T>? get currentData {
    final value = _currentData;
    if (value == null) return null;
    if (_currentData is EqualUnmodifiableListView) return _currentData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? message;

  @override
  String toString() {
    return 'ListState<$T>.loading(currentData: $currentData, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListLoadingImpl<T> &&
            const DeepCollectionEquality()
                .equals(other._currentData, _currentData) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_currentData), message);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListLoadingImplCopyWith<T, _$ListLoadingImpl<T>> get copyWith =>
      __$$ListLoadingImplCopyWithImpl<T, _$ListLoadingImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return loading(currentData, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return loading?.call(currentData, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(currentData, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ListLoading<T> implements ListState<T> {
  const factory _ListLoading(
      {final List<T>? currentData,
      final String? message}) = _$ListLoadingImpl<T>;

  List<T>? get currentData;
  String? get message;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListLoadingImplCopyWith<T, _$ListLoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListSuccessImplCopyWith<T, $Res> {
  factory _$$ListSuccessImplCopyWith(_$ListSuccessImpl<T> value,
          $Res Function(_$ListSuccessImpl<T>) then) =
      __$$ListSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> data, bool hasMore, String? message});
}

/// @nodoc
class __$$ListSuccessImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListSuccessImpl<T>>
    implements _$$ListSuccessImplCopyWith<T, $Res> {
  __$$ListSuccessImplCopyWithImpl(
      _$ListSuccessImpl<T> _value, $Res Function(_$ListSuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? hasMore = null,
    Object? message = freezed,
  }) {
    return _then(_$ListSuccessImpl<T>(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ListSuccessImpl<T> implements _ListSuccess<T> {
  const _$ListSuccessImpl(
      {required final List<T> data, this.hasMore = false, this.message})
      : _data = data;

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? message;

  @override
  String toString() {
    return 'ListState<$T>.success(data: $data, hasMore: $hasMore, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_data), hasMore, message);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListSuccessImplCopyWith<T, _$ListSuccessImpl<T>> get copyWith =>
      __$$ListSuccessImplCopyWithImpl<T, _$ListSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return success(data, hasMore, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return success?.call(data, hasMore, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, hasMore, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _ListSuccess<T> implements ListState<T> {
  const factory _ListSuccess(
      {required final List<T> data,
      final bool hasMore,
      final String? message}) = _$ListSuccessImpl<T>;

  List<T> get data;
  bool get hasMore;
  String? get message;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListSuccessImplCopyWith<T, _$ListSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListErrorImplCopyWith<T, $Res> {
  factory _$$ListErrorImplCopyWith(
          _$ListErrorImpl<T> value, $Res Function(_$ListErrorImpl<T>) then) =
      __$$ListErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message, List<T>? currentData, Object? exception});
}

/// @nodoc
class __$$ListErrorImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListErrorImpl<T>>
    implements _$$ListErrorImplCopyWith<T, $Res> {
  __$$ListErrorImplCopyWithImpl(
      _$ListErrorImpl<T> _value, $Res Function(_$ListErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentData = freezed,
    Object? exception = freezed,
  }) {
    return _then(_$ListErrorImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      currentData: freezed == currentData
          ? _value._currentData
          : currentData // ignore: cast_nullable_to_non_nullable
              as List<T>?,
      exception: freezed == exception ? _value.exception : exception,
    ));
  }
}

/// @nodoc

class _$ListErrorImpl<T> implements _ListError<T> {
  const _$ListErrorImpl(
      {required this.message, final List<T>? currentData, this.exception})
      : _currentData = currentData;

  @override
  final String message;
  final List<T>? _currentData;
  @override
  List<T>? get currentData {
    final value = _currentData;
    if (value == null) return null;
    if (_currentData is EqualUnmodifiableListView) return _currentData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Object? exception;

  @override
  String toString() {
    return 'ListState<$T>.error(message: $message, currentData: $currentData, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListErrorImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._currentData, _currentData) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      const DeepCollectionEquality().hash(_currentData),
      const DeepCollectionEquality().hash(exception));

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListErrorImplCopyWith<T, _$ListErrorImpl<T>> get copyWith =>
      __$$ListErrorImplCopyWithImpl<T, _$ListErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return error(message, currentData, exception);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return error?.call(message, currentData, exception);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, currentData, exception);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ListError<T> implements ListState<T> {
  const factory _ListError(
      {required final String message,
      final List<T>? currentData,
      final Object? exception}) = _$ListErrorImpl<T>;

  String get message;
  List<T>? get currentData;
  Object? get exception;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListErrorImplCopyWith<T, _$ListErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListRefreshingImplCopyWith<T, $Res> {
  factory _$$ListRefreshingImplCopyWith(_$ListRefreshingImpl<T> value,
          $Res Function(_$ListRefreshingImpl<T>) then) =
      __$$ListRefreshingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> currentData});
}

/// @nodoc
class __$$ListRefreshingImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListRefreshingImpl<T>>
    implements _$$ListRefreshingImplCopyWith<T, $Res> {
  __$$ListRefreshingImplCopyWithImpl(_$ListRefreshingImpl<T> _value,
      $Res Function(_$ListRefreshingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentData = null,
  }) {
    return _then(_$ListRefreshingImpl<T>(
      currentData: null == currentData
          ? _value._currentData
          : currentData // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$ListRefreshingImpl<T> implements _ListRefreshing<T> {
  const _$ListRefreshingImpl({required final List<T> currentData})
      : _currentData = currentData;

  final List<T> _currentData;
  @override
  List<T> get currentData {
    if (_currentData is EqualUnmodifiableListView) return _currentData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentData);
  }

  @override
  String toString() {
    return 'ListState<$T>.refreshing(currentData: $currentData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListRefreshingImpl<T> &&
            const DeepCollectionEquality()
                .equals(other._currentData, _currentData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_currentData));

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListRefreshingImplCopyWith<T, _$ListRefreshingImpl<T>> get copyWith =>
      __$$ListRefreshingImplCopyWithImpl<T, _$ListRefreshingImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return refreshing(currentData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return refreshing?.call(currentData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) {
    if (refreshing != null) {
      return refreshing(currentData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return refreshing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return refreshing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (refreshing != null) {
      return refreshing(this);
    }
    return orElse();
  }
}

abstract class _ListRefreshing<T> implements ListState<T> {
  const factory _ListRefreshing({required final List<T> currentData}) =
      _$ListRefreshingImpl<T>;

  List<T> get currentData;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListRefreshingImplCopyWith<T, _$ListRefreshingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ListLoadingMoreImplCopyWith<T, $Res> {
  factory _$$ListLoadingMoreImplCopyWith(_$ListLoadingMoreImpl<T> value,
          $Res Function(_$ListLoadingMoreImpl<T>) then) =
      __$$ListLoadingMoreImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> currentData});
}

/// @nodoc
class __$$ListLoadingMoreImplCopyWithImpl<T, $Res>
    extends _$ListStateCopyWithImpl<T, $Res, _$ListLoadingMoreImpl<T>>
    implements _$$ListLoadingMoreImplCopyWith<T, $Res> {
  __$$ListLoadingMoreImplCopyWithImpl(_$ListLoadingMoreImpl<T> _value,
      $Res Function(_$ListLoadingMoreImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentData = null,
  }) {
    return _then(_$ListLoadingMoreImpl<T>(
      currentData: null == currentData
          ? _value._currentData
          : currentData // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$ListLoadingMoreImpl<T> implements _ListLoadingMore<T> {
  const _$ListLoadingMoreImpl({required final List<T> currentData})
      : _currentData = currentData;

  final List<T> _currentData;
  @override
  List<T> get currentData {
    if (_currentData is EqualUnmodifiableListView) return _currentData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentData);
  }

  @override
  String toString() {
    return 'ListState<$T>.loadingMore(currentData: $currentData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListLoadingMoreImpl<T> &&
            const DeepCollectionEquality()
                .equals(other._currentData, _currentData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_currentData));

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListLoadingMoreImplCopyWith<T, _$ListLoadingMoreImpl<T>> get copyWith =>
      __$$ListLoadingMoreImplCopyWithImpl<T, _$ListLoadingMoreImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<T>? currentData, String? message) loading,
    required TResult Function(List<T> data, bool hasMore, String? message)
        success,
    required TResult Function(
            String message, List<T>? currentData, Object? exception)
        error,
    required TResult Function(List<T> currentData) refreshing,
    required TResult Function(List<T> currentData) loadingMore,
  }) {
    return loadingMore(currentData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(List<T>? currentData, String? message)? loading,
    TResult? Function(List<T> data, bool hasMore, String? message)? success,
    TResult? Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult? Function(List<T> currentData)? refreshing,
    TResult? Function(List<T> currentData)? loadingMore,
  }) {
    return loadingMore?.call(currentData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<T>? currentData, String? message)? loading,
    TResult Function(List<T> data, bool hasMore, String? message)? success,
    TResult Function(String message, List<T>? currentData, Object? exception)?
        error,
    TResult Function(List<T> currentData)? refreshing,
    TResult Function(List<T> currentData)? loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(currentData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ListInitial<T> value) initial,
    required TResult Function(_ListLoading<T> value) loading,
    required TResult Function(_ListSuccess<T> value) success,
    required TResult Function(_ListError<T> value) error,
    required TResult Function(_ListRefreshing<T> value) refreshing,
    required TResult Function(_ListLoadingMore<T> value) loadingMore,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ListInitial<T> value)? initial,
    TResult? Function(_ListLoading<T> value)? loading,
    TResult? Function(_ListSuccess<T> value)? success,
    TResult? Function(_ListError<T> value)? error,
    TResult? Function(_ListRefreshing<T> value)? refreshing,
    TResult? Function(_ListLoadingMore<T> value)? loadingMore,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ListInitial<T> value)? initial,
    TResult Function(_ListLoading<T> value)? loading,
    TResult Function(_ListSuccess<T> value)? success,
    TResult Function(_ListError<T> value)? error,
    TResult Function(_ListRefreshing<T> value)? refreshing,
    TResult Function(_ListLoadingMore<T> value)? loadingMore,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _ListLoadingMore<T> implements ListState<T> {
  const factory _ListLoadingMore({required final List<T> currentData}) =
      _$ListLoadingMoreImpl<T>;

  List<T> get currentData;

  /// Create a copy of ListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListLoadingMoreImplCopyWith<T, _$ListLoadingMoreImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaginationState<T> {
  List<T> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationStateCopyWith<T, PaginationState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationStateCopyWith<T, $Res> {
  factory $PaginationStateCopyWith(
          PaginationState<T> value, $Res Function(PaginationState<T>) then) =
      _$PaginationStateCopyWithImpl<T, $Res, PaginationState<T>>;
  @useResult
  $Res call(
      {List<T> items,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      int currentPage,
      String? error});
}

/// @nodoc
class _$PaginationStateCopyWithImpl<T, $Res, $Val extends PaginationState<T>>
    implements $PaginationStateCopyWith<T, $Res> {
  _$PaginationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationStateImplCopyWith<T, $Res>
    implements $PaginationStateCopyWith<T, $Res> {
  factory _$$PaginationStateImplCopyWith(_$PaginationStateImpl<T> value,
          $Res Function(_$PaginationStateImpl<T>) then) =
      __$$PaginationStateImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {List<T> items,
      bool isLoading,
      bool isLoadingMore,
      bool hasMore,
      int currentPage,
      String? error});
}

/// @nodoc
class __$$PaginationStateImplCopyWithImpl<T, $Res>
    extends _$PaginationStateCopyWithImpl<T, $Res, _$PaginationStateImpl<T>>
    implements _$$PaginationStateImplCopyWith<T, $Res> {
  __$$PaginationStateImplCopyWithImpl(_$PaginationStateImpl<T> _value,
      $Res Function(_$PaginationStateImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? error = freezed,
  }) {
    return _then(_$PaginationStateImpl<T>(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PaginationStateImpl<T> implements _PaginationState<T> {
  const _$PaginationStateImpl(
      {final List<T> items = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasMore = true,
      this.currentPage = 1,
      this.error})
      : _items = items;

  final List<T> _items;
  @override
  @JsonKey()
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int currentPage;
  @override
  final String? error;

  @override
  String toString() {
    return 'PaginationState<$T>(items: $items, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentPage: $currentPage, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationStateImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      isLoading,
      isLoadingMore,
      hasMore,
      currentPage,
      error);

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationStateImplCopyWith<T, _$PaginationStateImpl<T>> get copyWith =>
      __$$PaginationStateImplCopyWithImpl<T, _$PaginationStateImpl<T>>(
          this, _$identity);
}

abstract class _PaginationState<T> implements PaginationState<T> {
  const factory _PaginationState(
      {final List<T> items,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasMore,
      final int currentPage,
      final String? error}) = _$PaginationStateImpl<T>;

  @override
  List<T> get items;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  int get currentPage;
  @override
  String? get error;

  /// Create a copy of PaginationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationStateImplCopyWith<T, _$PaginationStateImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

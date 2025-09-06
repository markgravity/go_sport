// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDetailsStateCopyWith<$Res> {
  factory $GroupDetailsStateCopyWith(
          GroupDetailsState value, $Res Function(GroupDetailsState) then) =
      _$GroupDetailsStateCopyWithImpl<$Res, GroupDetailsState>;
}

/// @nodoc
class _$GroupDetailsStateCopyWithImpl<$Res, $Val extends GroupDetailsState>
    implements $GroupDetailsStateCopyWith<$Res> {
  _$GroupDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupDetailsState
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
    extends _$GroupDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'GroupDetailsState.initial()';
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
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements GroupDetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int groupId, String message});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$GroupDetailsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? message = null,
  }) {
    return _then(_$LoadingImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(
      {required this.groupId, this.message = 'Đang tải thông tin nhóm...'});

  /// Group ID đang load
  @override
  final int groupId;

  /// Thông báo loading
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'GroupDetailsState.loading(groupId: $groupId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId, message);

  /// Create a copy of GroupDetailsState
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
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) {
    return loading(groupId, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) {
    return loading?.call(groupId, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(groupId, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements GroupDetailsState {
  const factory _Loading({required final int groupId, final String message}) =
      _$LoadingImpl;

  /// Group ID đang load
  int get groupId;

  /// Thông báo loading
  String get message;

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {Group group,
      List<User> members,
      GroupRole? currentUserRole,
      bool canManageGroup,
      bool canAssignRoles,
      String? message});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$GroupDetailsStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? members = null,
    Object? currentUserRole = freezed,
    Object? canManageGroup = null,
    Object? canAssignRoles = null,
    Object? message = freezed,
  }) {
    return _then(_$LoadedImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<User>,
      currentUserRole: freezed == currentUserRole
          ? _value.currentUserRole
          : currentUserRole // ignore: cast_nullable_to_non_nullable
              as GroupRole?,
      canManageGroup: null == canManageGroup
          ? _value.canManageGroup
          : canManageGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      canAssignRoles: null == canAssignRoles
          ? _value.canAssignRoles
          : canAssignRoles // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.group,
      final List<User> members = const [],
      this.currentUserRole,
      this.canManageGroup = false,
      this.canAssignRoles = false,
      this.message})
      : _members = members;

  /// Group details
  @override
  final Group group;

  /// Danh sách members
  final List<User> _members;

  /// Danh sách members
  @override
  @JsonKey()
  List<User> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Role của current user trong group
  @override
  final GroupRole? currentUserRole;

  /// Có quyền manage group không
  @override
  @JsonKey()
  final bool canManageGroup;

  /// Có quyền assign roles không
  @override
  @JsonKey()
  final bool canAssignRoles;

  /// Message thông báo (nếu có)
  @override
  final String? message;

  @override
  String toString() {
    return 'GroupDetailsState.loaded(group: $group, members: $members, currentUserRole: $currentUserRole, canManageGroup: $canManageGroup, canAssignRoles: $canAssignRoles, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.currentUserRole, currentUserRole) ||
                other.currentUserRole == currentUserRole) &&
            (identical(other.canManageGroup, canManageGroup) ||
                other.canManageGroup == canManageGroup) &&
            (identical(other.canAssignRoles, canAssignRoles) ||
                other.canAssignRoles == canAssignRoles) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      group,
      const DeepCollectionEquality().hash(_members),
      currentUserRole,
      canManageGroup,
      canAssignRoles,
      message);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) {
    return loaded(group, members, currentUserRole, canManageGroup,
        canAssignRoles, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) {
    return loaded?.call(group, members, currentUserRole, canManageGroup,
        canAssignRoles, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(group, members, currentUserRole, canManageGroup,
          canAssignRoles, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements GroupDetailsState {
  const factory _Loaded(
      {required final Group group,
      final List<User> members,
      final GroupRole? currentUserRole,
      final bool canManageGroup,
      final bool canAssignRoles,
      final String? message}) = _$LoadedImpl;

  /// Group details
  Group get group;

  /// Danh sách members
  List<User> get members;

  /// Role của current user trong group
  GroupRole? get currentUserRole;

  /// Có quyền manage group không
  bool get canManageGroup;

  /// Có quyền assign roles không
  bool get canAssignRoles;

  /// Message thông báo (nếu có)
  String? get message;

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatingImplCopyWith<$Res> {
  factory _$$UpdatingImplCopyWith(
          _$UpdatingImpl value, $Res Function(_$UpdatingImpl) then) =
      __$$UpdatingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Group group, List<User> members, String action, String message});
}

/// @nodoc
class __$$UpdatingImplCopyWithImpl<$Res>
    extends _$GroupDetailsStateCopyWithImpl<$Res, _$UpdatingImpl>
    implements _$$UpdatingImplCopyWith<$Res> {
  __$$UpdatingImplCopyWithImpl(
      _$UpdatingImpl _value, $Res Function(_$UpdatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? members = null,
    Object? action = null,
    Object? message = null,
  }) {
    return _then(_$UpdatingImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<User>,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdatingImpl implements _Updating {
  const _$UpdatingImpl(
      {required this.group,
      final List<User> members = const [],
      required this.action,
      required this.message})
      : _members = members;

  /// Group hiện tại
  @override
  final Group group;

  /// Members hiện tại
  final List<User> _members;

  /// Members hiện tại
  @override
  @JsonKey()
  List<User> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Action đang thực hiện
  @override
  final String action;

  /// Progress message
  @override
  final String message;

  @override
  String toString() {
    return 'GroupDetailsState.updating(group: $group, members: $members, action: $action, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatingImpl &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, group,
      const DeepCollectionEquality().hash(_members), action, message);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatingImplCopyWith<_$UpdatingImpl> get copyWith =>
      __$$UpdatingImplCopyWithImpl<_$UpdatingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) {
    return updating(group, members, action, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) {
    return updating?.call(group, members, action, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating(group, members, action, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) {
    return updating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) {
    return updating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating(this);
    }
    return orElse();
  }
}

abstract class _Updating implements GroupDetailsState {
  const factory _Updating(
      {required final Group group,
      final List<User> members,
      required final String action,
      required final String message}) = _$UpdatingImpl;

  /// Group hiện tại
  Group get group;

  /// Members hiện tại
  List<User> get members;

  /// Action đang thực hiện
  String get action;

  /// Progress message
  String get message;

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatingImplCopyWith<_$UpdatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupDetailsErrorImplCopyWith<$Res> {
  factory _$$GroupDetailsErrorImplCopyWith(_$GroupDetailsErrorImpl value,
          $Res Function(_$GroupDetailsErrorImpl) then) =
      __$$GroupDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String message,
      Group? group,
      List<User> members,
      Object? exception,
      String? errorCode});
}

/// @nodoc
class __$$GroupDetailsErrorImplCopyWithImpl<$Res>
    extends _$GroupDetailsStateCopyWithImpl<$Res, _$GroupDetailsErrorImpl>
    implements _$$GroupDetailsErrorImplCopyWith<$Res> {
  __$$GroupDetailsErrorImplCopyWithImpl(_$GroupDetailsErrorImpl _value,
      $Res Function(_$GroupDetailsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? group = freezed,
    Object? members = null,
    Object? exception = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(_$GroupDetailsErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as Group?,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<User>,
      exception: freezed == exception ? _value.exception : exception,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GroupDetailsErrorImpl implements _GroupDetailsError {
  const _$GroupDetailsErrorImpl(
      {required this.message,
      this.group,
      final List<User> members = const [],
      this.exception,
      this.errorCode})
      : _members = members;

  /// Thông báo lỗi bằng tiếng Việt
  @override
  final String message;

  /// Group hiện tại (để preserve UI)
  @override
  final Group? group;

  /// Members hiện tại (để preserve UI)
  final List<User> _members;

  /// Members hiện tại (để preserve UI)
  @override
  @JsonKey()
  List<User> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  /// Exception gốc
  @override
  final Object? exception;

  /// Error code
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'GroupDetailsState.error(message: $message, group: $group, members: $members, exception: $exception, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailsErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other.exception, exception) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      group,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(exception),
      errorCode);

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailsErrorImplCopyWith<_$GroupDetailsErrorImpl> get copyWith =>
      __$$GroupDetailsErrorImplCopyWithImpl<_$GroupDetailsErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int groupId, String message) loading,
    required TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)
        loaded,
    required TResult Function(
            Group group, List<User> members, String action, String message)
        updating,
    required TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)
        error,
  }) {
    return error(message, group, members, exception, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int groupId, String message)? loading,
    TResult? Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult? Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult? Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
  }) {
    return error?.call(message, group, members, exception, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int groupId, String message)? loading,
    TResult Function(
            Group group,
            List<User> members,
            GroupRole? currentUserRole,
            bool canManageGroup,
            bool canAssignRoles,
            String? message)?
        loaded,
    TResult Function(
            Group group, List<User> members, String action, String message)?
        updating,
    TResult Function(String message, Group? group, List<User> members,
            Object? exception, String? errorCode)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, group, members, exception, errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Updating value) updating,
    required TResult Function(_GroupDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Updating value)? updating,
    TResult? Function(_GroupDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Updating value)? updating,
    TResult Function(_GroupDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _GroupDetailsError implements GroupDetailsState {
  const factory _GroupDetailsError(
      {required final String message,
      final Group? group,
      final List<User> members,
      final Object? exception,
      final String? errorCode}) = _$GroupDetailsErrorImpl;

  /// Thông báo lỗi bằng tiếng Việt
  String get message;

  /// Group hiện tại (để preserve UI)
  Group? get group;

  /// Members hiện tại (để preserve UI)
  List<User> get members;

  /// Exception gốc
  Object? get exception;

  /// Error code
  String? get errorCode;

  /// Create a copy of GroupDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupDetailsErrorImplCopyWith<_$GroupDetailsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

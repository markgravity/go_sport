// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InvitationManagementState {
  List<GroupInvitation> get invitations => throw _privateConstructorUsedError;
  List<GroupJoinRequest> get joinRequests => throw _privateConstructorUsedError;
  bool get isLoadingInvitations => throw _privateConstructorUsedError;
  bool get isLoadingJoinRequests => throw _privateConstructorUsedError;
  bool get isCreatingInvitation => throw _privateConstructorUsedError;
  bool get isProcessingRequest => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  InvitationTab get currentTab => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)?
        $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)?
        $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationManagementState value) $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationManagementState value)? $default,
  ) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationManagementState value)? $default, {
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of InvitationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationManagementStateCopyWith<InvitationManagementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationManagementStateCopyWith<$Res> {
  factory $InvitationManagementStateCopyWith(InvitationManagementState value,
          $Res Function(InvitationManagementState) then) =
      _$InvitationManagementStateCopyWithImpl<$Res, InvitationManagementState>;
  @useResult
  $Res call(
      {List<GroupInvitation> invitations,
      List<GroupJoinRequest> joinRequests,
      bool isLoadingInvitations,
      bool isLoadingJoinRequests,
      bool isCreatingInvitation,
      bool isProcessingRequest,
      String? errorMessage,
      String? successMessage,
      InvitationTab currentTab});
}

/// @nodoc
class _$InvitationManagementStateCopyWithImpl<$Res,
        $Val extends InvitationManagementState>
    implements $InvitationManagementStateCopyWith<$Res> {
  _$InvitationManagementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitations = null,
    Object? joinRequests = null,
    Object? isLoadingInvitations = null,
    Object? isLoadingJoinRequests = null,
    Object? isCreatingInvitation = null,
    Object? isProcessingRequest = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? currentTab = null,
  }) {
    return _then(_value.copyWith(
      invitations: null == invitations
          ? _value.invitations
          : invitations // ignore: cast_nullable_to_non_nullable
              as List<GroupInvitation>,
      joinRequests: null == joinRequests
          ? _value.joinRequests
          : joinRequests // ignore: cast_nullable_to_non_nullable
              as List<GroupJoinRequest>,
      isLoadingInvitations: null == isLoadingInvitations
          ? _value.isLoadingInvitations
          : isLoadingInvitations // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingJoinRequests: null == isLoadingJoinRequests
          ? _value.isLoadingJoinRequests
          : isLoadingJoinRequests // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingInvitation: null == isCreatingInvitation
          ? _value.isCreatingInvitation
          : isCreatingInvitation // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingRequest: null == isProcessingRequest
          ? _value.isProcessingRequest
          : isProcessingRequest // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as InvitationTab,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationManagementStateImplCopyWith<$Res>
    implements $InvitationManagementStateCopyWith<$Res> {
  factory _$$InvitationManagementStateImplCopyWith(
          _$InvitationManagementStateImpl value,
          $Res Function(_$InvitationManagementStateImpl) then) =
      __$$InvitationManagementStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<GroupInvitation> invitations,
      List<GroupJoinRequest> joinRequests,
      bool isLoadingInvitations,
      bool isLoadingJoinRequests,
      bool isCreatingInvitation,
      bool isProcessingRequest,
      String? errorMessage,
      String? successMessage,
      InvitationTab currentTab});
}

/// @nodoc
class __$$InvitationManagementStateImplCopyWithImpl<$Res>
    extends _$InvitationManagementStateCopyWithImpl<$Res,
        _$InvitationManagementStateImpl>
    implements _$$InvitationManagementStateImplCopyWith<$Res> {
  __$$InvitationManagementStateImplCopyWithImpl(
      _$InvitationManagementStateImpl _value,
      $Res Function(_$InvitationManagementStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InvitationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invitations = null,
    Object? joinRequests = null,
    Object? isLoadingInvitations = null,
    Object? isLoadingJoinRequests = null,
    Object? isCreatingInvitation = null,
    Object? isProcessingRequest = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? currentTab = null,
  }) {
    return _then(_$InvitationManagementStateImpl(
      invitations: null == invitations
          ? _value._invitations
          : invitations // ignore: cast_nullable_to_non_nullable
              as List<GroupInvitation>,
      joinRequests: null == joinRequests
          ? _value._joinRequests
          : joinRequests // ignore: cast_nullable_to_non_nullable
              as List<GroupJoinRequest>,
      isLoadingInvitations: null == isLoadingInvitations
          ? _value.isLoadingInvitations
          : isLoadingInvitations // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingJoinRequests: null == isLoadingJoinRequests
          ? _value.isLoadingJoinRequests
          : isLoadingJoinRequests // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingInvitation: null == isCreatingInvitation
          ? _value.isCreatingInvitation
          : isCreatingInvitation // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessingRequest: null == isProcessingRequest
          ? _value.isProcessingRequest
          : isProcessingRequest // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTab: null == currentTab
          ? _value.currentTab
          : currentTab // ignore: cast_nullable_to_non_nullable
              as InvitationTab,
    ));
  }
}

/// @nodoc

class _$InvitationManagementStateImpl implements _InvitationManagementState {
  const _$InvitationManagementStateImpl(
      {final List<GroupInvitation> invitations = const [],
      final List<GroupJoinRequest> joinRequests = const [],
      this.isLoadingInvitations = false,
      this.isLoadingJoinRequests = false,
      this.isCreatingInvitation = false,
      this.isProcessingRequest = false,
      this.errorMessage,
      this.successMessage,
      this.currentTab = InvitationTab.invitations})
      : _invitations = invitations,
        _joinRequests = joinRequests;

  final List<GroupInvitation> _invitations;
  @override
  @JsonKey()
  List<GroupInvitation> get invitations {
    if (_invitations is EqualUnmodifiableListView) return _invitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invitations);
  }

  final List<GroupJoinRequest> _joinRequests;
  @override
  @JsonKey()
  List<GroupJoinRequest> get joinRequests {
    if (_joinRequests is EqualUnmodifiableListView) return _joinRequests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_joinRequests);
  }

  @override
  @JsonKey()
  final bool isLoadingInvitations;
  @override
  @JsonKey()
  final bool isLoadingJoinRequests;
  @override
  @JsonKey()
  final bool isCreatingInvitation;
  @override
  @JsonKey()
  final bool isProcessingRequest;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;
  @override
  @JsonKey()
  final InvitationTab currentTab;

  @override
  String toString() {
    return 'InvitationManagementState(invitations: $invitations, joinRequests: $joinRequests, isLoadingInvitations: $isLoadingInvitations, isLoadingJoinRequests: $isLoadingJoinRequests, isCreatingInvitation: $isCreatingInvitation, isProcessingRequest: $isProcessingRequest, errorMessage: $errorMessage, successMessage: $successMessage, currentTab: $currentTab)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationManagementStateImpl &&
            const DeepCollectionEquality()
                .equals(other._invitations, _invitations) &&
            const DeepCollectionEquality()
                .equals(other._joinRequests, _joinRequests) &&
            (identical(other.isLoadingInvitations, isLoadingInvitations) ||
                other.isLoadingInvitations == isLoadingInvitations) &&
            (identical(other.isLoadingJoinRequests, isLoadingJoinRequests) ||
                other.isLoadingJoinRequests == isLoadingJoinRequests) &&
            (identical(other.isCreatingInvitation, isCreatingInvitation) ||
                other.isCreatingInvitation == isCreatingInvitation) &&
            (identical(other.isProcessingRequest, isProcessingRequest) ||
                other.isProcessingRequest == isProcessingRequest) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.currentTab, currentTab) ||
                other.currentTab == currentTab));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_invitations),
      const DeepCollectionEquality().hash(_joinRequests),
      isLoadingInvitations,
      isLoadingJoinRequests,
      isCreatingInvitation,
      isProcessingRequest,
      errorMessage,
      successMessage,
      currentTab);

  /// Create a copy of InvitationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationManagementStateImplCopyWith<_$InvitationManagementStateImpl>
      get copyWith => __$$InvitationManagementStateImplCopyWithImpl<
          _$InvitationManagementStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)
        $default,
  ) {
    return $default(
        invitations,
        joinRequests,
        isLoadingInvitations,
        isLoadingJoinRequests,
        isCreatingInvitation,
        isProcessingRequest,
        errorMessage,
        successMessage,
        currentTab);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)?
        $default,
  ) {
    return $default?.call(
        invitations,
        joinRequests,
        isLoadingInvitations,
        isLoadingJoinRequests,
        isCreatingInvitation,
        isProcessingRequest,
        errorMessage,
        successMessage,
        currentTab);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<GroupInvitation> invitations,
            List<GroupJoinRequest> joinRequests,
            bool isLoadingInvitations,
            bool isLoadingJoinRequests,
            bool isCreatingInvitation,
            bool isProcessingRequest,
            String? errorMessage,
            String? successMessage,
            InvitationTab currentTab)?
        $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          invitations,
          joinRequests,
          isLoadingInvitations,
          isLoadingJoinRequests,
          isCreatingInvitation,
          isProcessingRequest,
          errorMessage,
          successMessage,
          currentTab);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_InvitationManagementState value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_InvitationManagementState value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_InvitationManagementState value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _InvitationManagementState implements InvitationManagementState {
  const factory _InvitationManagementState(
      {final List<GroupInvitation> invitations,
      final List<GroupJoinRequest> joinRequests,
      final bool isLoadingInvitations,
      final bool isLoadingJoinRequests,
      final bool isCreatingInvitation,
      final bool isProcessingRequest,
      final String? errorMessage,
      final String? successMessage,
      final InvitationTab currentTab}) = _$InvitationManagementStateImpl;

  @override
  List<GroupInvitation> get invitations;
  @override
  List<GroupJoinRequest> get joinRequests;
  @override
  bool get isLoadingInvitations;
  @override
  bool get isLoadingJoinRequests;
  @override
  bool get isCreatingInvitation;
  @override
  bool get isProcessingRequest;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;
  @override
  InvitationTab get currentTab;

  /// Create a copy of InvitationManagementState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationManagementStateImplCopyWith<_$InvitationManagementStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

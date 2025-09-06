import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/group.dart';
import '../../models/group_role.dart';

part 'group_details_state.freezed.dart';

/// GroupDetailsState cho Group Details Management
/// 
/// Quản lý trạng thái chi tiết nhóm với Vietnamese role management
/// Hỗ trợ member management và Vietnamese cultural patterns
@freezed
class GroupDetailsState with _$GroupDetailsState {
  /// Trạng thái ban đầu
  const factory GroupDetailsState.initial() = _Initial;
  
  /// Trạng thái đang load group details
  const factory GroupDetailsState.loading({
    /// Group ID đang load
    required int groupId,
    /// Thông báo loading
    @Default('Đang tải thông tin nhóm...') String message,
  }) = _Loading;
  
  /// Trạng thái đã load thành công
  const factory GroupDetailsState.loaded({
    /// Group details
    required Group group,
    /// Danh sách members
    @Default([]) List<User> members,
    /// Role của current user trong group
    GroupRole? currentUserRole,
    /// Có quyền manage group không
    @Default(false) bool canManageGroup,
    /// Có quyền assign roles không
    @Default(false) bool canAssignRoles,
    /// Message thông báo (nếu có)
    String? message,
  }) = _Loaded;
  
  /// Trạng thái đang update group hoặc member roles
  const factory GroupDetailsState.updating({
    /// Group hiện tại
    required Group group,
    /// Members hiện tại
    @Default([]) List<User> members,
    /// Action đang thực hiện
    required String action,
    /// Progress message
    required String message,
  }) = _Updating;
  
  /// Trạng thái lỗi
  const factory GroupDetailsState.error({
    /// Thông báo lỗi bằng tiếng Việt
    required String message,
    /// Group hiện tại (để preserve UI)
    Group? group,
    /// Members hiện tại (để preserve UI)
    @Default([]) List<User> members,
    /// Exception gốc
    Object? exception,
    /// Error code
    String? errorCode,
  }) = _GroupDetailsError;
}

/// Extension methods for GroupDetailsState
extension GroupDetailsStateExtension on GroupDetailsState {
  /// Kiểm tra có đang loading không
  bool get isLoading => when(
    initial: () => false,
    loading: (_, __) => true,
    loaded: (_, __, ___, ____, _____, ______) => false,
    updating: (_, __, ___, ____) => true,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra có data không
  bool get hasData => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______) => true,
    updating: (_, __, ___, ____) => true,
    error: (_, group, __, ___, ____) => group != null,
  );
  
  /// Kiểm tra có lỗi không
  bool get hasError => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______) => false,
    updating: (_, __, ___, ____) => false,
    error: (_, __, ___, ____, _____) => true,
  );
  
  /// Lấy group hiện tại
  Group? get currentGroup => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (group, _, __, ___, ____, _____) => group,
    updating: (group, _, __, ___) => group,
    error: (_, group, __, ___, ____) => group,
  );
  
  /// Lấy danh sách members
  List<User> get currentMembers => when(
    initial: () => <User>[],
    loading: (_, __) => <User>[],
    loaded: (_, members, __, ___, ____, _____) => members,
    updating: (_, members, __, ___) => members,
    error: (_, __, members, ___, ____) => members,
  );
  
  /// Lấy current user role
  GroupRole? get currentUserRole => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, role, ___, ____, _____) => role,
    updating: (_, __, ___, ____) => null,
    error: (_, __, ___, ____, _____) => null,
  );
  
  /// Kiểm tra có quyền manage không
  bool get canManage => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, canManage, ____, _____) => canManage,
    updating: (_, __, ___, ____) => false,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Kiểm tra có quyền assign roles không
  bool get canAssignRoles => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, canAssign, _____) => canAssign,
    updating: (_, __, ___, ____) => false,
    error: (_, __, ___, ____, _____) => false,
  );
  
  /// Lấy error message
  String? get errorMessage => when(
    initial: () => null,
    loading: (_, __) => null,
    loaded: (_, __, ___, ____, _____, ______) => null,
    updating: (_, __, ___, ____) => null,
    error: (message, _, __, ___, ____) => message,
  );
  
  /// Lấy display message cho UI
  String? get displayMessage => when(
    initial: () => null,
    loading: (_, message) => message,
    loaded: (_, __, ___, ____, _____, message) => message,
    updating: (_, __, ___, message) => message,
    error: (message, _, __, ___, ____) => message,
  );
  
  /// Kiểm tra user có phải là group creator không
  bool get isCreator => currentUserRole == GroupRole.admin;
  
  /// Kiểm tra user có phải là moderator hoặc cao hơn không
  bool get isModerator => currentUserRole != null && 
      (currentUserRole == GroupRole.admin || currentUserRole == GroupRole.moderator);
  
  /// Kiểm tra group có đầy thành viên không
  bool get isGroupFull => currentGroup?.isFull ?? false;
  
  /// Lấy số thành viên hiện tại
  int get memberCount => currentMembers.length;
  
  /// Lấy tên nhóm (cho title)
  String get groupName => currentGroup?.name ?? 'Nhóm';
  
  /// Lấy sport type Vietnamese name
  String get sportName => currentGroup?.sportName ?? '';
  
  /// Kiểm tra có đang update không
  bool get isUpdating => when(
    initial: () => false,
    loading: (_, __) => false,
    loaded: (_, __, ___, ____, _____, ______) => false,
    updating: (_, __, ___, ____) => true,
    error: (_, __, ___, ____, _____) => false,
  );
}
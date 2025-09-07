enum GroupRole {
  admin('admin'),
  moderator('moderator'),
  member('member'),
  guest('guest');

  const GroupRole(this.value);
  final String value;

  /// Get Vietnamese role name
  String get vietnamese {
    switch (this) {
      case GroupRole.admin:
        return 'Trưởng nhóm';
      case GroupRole.moderator:
        return 'Phó nhóm';
      case GroupRole.member:
        return 'Thành viên';
      case GroupRole.guest:
        return 'Khách';
    }
  }

  /// Get role description
  String get description {
    switch (this) {
      case GroupRole.admin:
        return 'Người tạo và quản lý nhóm, có toàn quyền';
      case GroupRole.moderator:
        return 'Hỗ trợ quản lý nhóm, có quyền hạn cao';
      case GroupRole.member:
        return 'Thành viên chính thức của nhóm';
      case GroupRole.guest:
        return 'Khách tham quan, quyền hạn hạn chế';
    }
  }

  /// Get role hierarchy level (lower number = higher authority)
  int get level {
    switch (this) {
      case GroupRole.admin:
        return 1;
      case GroupRole.moderator:
        return 2;
      case GroupRole.member:
        return 3;
      case GroupRole.guest:
        return 4;
    }
  }

  /// Check if this role can manage another role
  bool canManage(GroupRole otherRole) {
    return level < otherRole.level;
  }

  /// Get roles that can be assigned by this role
  List<GroupRole> get assignableRoles {
    switch (this) {
      case GroupRole.admin:
        return [GroupRole.moderator, GroupRole.member, GroupRole.guest];
      case GroupRole.moderator:
        return [GroupRole.member, GroupRole.guest];
      case GroupRole.member:
        return [];
      case GroupRole.guest:
        return [];
    }
  }

  /// Create from API value
  static GroupRole? fromValue(String? value) {
    if (value == null) return null;
    
    for (GroupRole role in GroupRole.values) {
      if (role.value == value) {
        return role;
      }
    }
    return null;
  }
}

/// Vietnamese-specific group roles for cultural patterns
enum VietnameseGroupRole {
  leader('truong_nhom'),
  coLeader('pho_nhom'),
  member('thanh_vien');

  const VietnameseGroupRole(this.value);
  final String value;

  /// Get Vietnamese role name
  String get vietnamese {
    switch (this) {
      case VietnameseGroupRole.leader:
        return 'Trưởng nhóm';
      case VietnameseGroupRole.coLeader:
        return 'Phó nhóm';
      case VietnameseGroupRole.member:
        return 'Thành viên';
    }
  }

  /// Get role description
  String get description {
    switch (this) {
      case VietnameseGroupRole.leader:
        return 'Người tạo và quản lý nhóm, có toàn quyền';
      case VietnameseGroupRole.coLeader:
        return 'Hỗ trợ quản lý nhóm, có quyền hạn cao';
      case VietnameseGroupRole.member:
        return 'Thành viên chính thức của nhóm';
    }
  }

  /// Get role hierarchy level (lower number = higher authority)
  int get level {
    switch (this) {
      case VietnameseGroupRole.leader:
        return 1;
      case VietnameseGroupRole.coLeader:
        return 2;
      case VietnameseGroupRole.member:
        return 3;
    }
  }

  /// Check if this role can manage another role
  bool canManage(VietnameseGroupRole otherRole) {
    return level < otherRole.level;
  }

  /// Get roles that can be assigned by this role
  List<VietnameseGroupRole> get assignableRoles {
    switch (this) {
      case VietnameseGroupRole.leader:
        return [VietnameseGroupRole.coLeader, VietnameseGroupRole.member];
      case VietnameseGroupRole.coLeader:
        return [VietnameseGroupRole.member];
      case VietnameseGroupRole.member:
        return [];
    }
  }

  /// Create from API value
  static VietnameseGroupRole? fromValue(String? value) {
    if (value == null) return null;
    
    for (VietnameseGroupRole role in VietnameseGroupRole.values) {
      if (role.value == value) {
        return role;
      }
    }
    return null;
  }
}
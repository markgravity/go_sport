// Hot reload trigger - fix navigation
class Group {
  final int id;
  final String name;
  final String? description;
  final String sportType;
  final String skillLevel;
  final String location;
  final String city;
  final String? district;
  final double? latitude;
  final double? longitude;
  final Map<String, dynamic>? schedule;
  final int maxMembers;
  final int currentMembers;
  final double membershipFee;
  final String privacy;
  final String status;
  final String? avatar;
  final Map<String, dynamic>? rules;
  final int creatorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? creator;
  final List<User>? activeMembers;
  final List<GroupMember>? members;

  Group({
    required this.id,
    required this.name,
    this.description,
    required this.sportType,
    required this.skillLevel,
    required this.location,
    required this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.schedule,
    required this.maxMembers,
    required this.currentMembers,
    required this.membershipFee,
    required this.privacy,
    required this.status,
    this.avatar,
    this.rules,
    required this.creatorId,
    required this.createdAt,
    required this.updatedAt,
    this.creator,
    this.activeMembers,
    this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Chưa có tên',
      description: json['description'] as String?,
      sportType: json['sport_type'] as String? ?? 'unknown',
      skillLevel: json['skill_level'] as String? ?? 'moi_bat_dau',
      location: json['location'] as String? ?? 'Chưa xác định',
      city: json['city'] as String? ?? 'Chưa xác định',
      district: json['district'] as String?,
      latitude: _convertToDouble(json['latitude']),
      longitude: _convertToDouble(json['longitude']),
      schedule: json['schedule'] is List 
          ? (json['schedule'] as List).isEmpty ? null : null
          : json['schedule'] as Map<String, dynamic>?,
      maxMembers: json['max_members'] as int? ?? 20,
      currentMembers: json['current_members'] as int? ?? 0,
      membershipFee: _convertToDouble(json['membership_fee'] ?? json['monthly_fee']) ?? 0.0,
      privacy: json['privacy'] as String? ?? 'cong_khai',
      status: json['status'] as String? ?? 'hoat_dong',
      avatar: json['avatar'] as String?,
      rules: json['rules'] is List 
          ? (json['rules'] as List).isEmpty ? null : null
          : json['rules'] as Map<String, dynamic>?,
      creatorId: json['creator_id'] as int? ?? 0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      activeMembers: json['active_members'] != null
          ? (json['active_members'] as List)
              .map((member) => User.fromJson(member))
              .toList()
          : null,
      members: json['members'] != null
          ? (json['members'] as List)
              .map((member) =>
                  GroupMember.fromJson(member as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sport_type': sportType,
      'skill_level': skillLevel,
      'location': location,
      'city': city,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      'schedule': schedule,
      'max_members': maxMembers,
      'current_members': currentMembers,
      'membership_fee': membershipFee,
      'privacy': privacy,
      'status': status,
      'avatar': avatar,
      'rules': rules,
      'creator_id': creatorId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Group copyWith({
    int? id,
    String? name,
    String? description,
    String? sportType,
    String? skillLevel,
    String? location,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? schedule,
    int? maxMembers,
    int? currentMembers,
    double? membershipFee,
    String? privacy,
    String? status,
    String? avatar,
    Map<String, dynamic>? rules,
    int? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? creator,
    List<User>? activeMembers,
    List<GroupMember>? members,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      sportType: sportType ?? this.sportType,
      skillLevel: skillLevel ?? this.skillLevel,
      location: location ?? this.location,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      schedule: schedule ?? this.schedule,
      maxMembers: maxMembers ?? this.maxMembers,
      currentMembers: currentMembers ?? this.currentMembers,
      membershipFee: membershipFee ?? this.membershipFee,
      privacy: privacy ?? this.privacy,
      status: status ?? this.status,
      avatar: avatar ?? this.avatar,
      rules: rules ?? this.rules,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creator: creator ?? this.creator,
      activeMembers: activeMembers ?? this.activeMembers,
      members: members ?? this.members,
    );
  }

  String get sportName {
    switch (sportType) {
      case 'cau_long':
        return 'Cầu lông';
      case 'bong_da':
        return 'Bóng đá';
      case 'bong_ro':
        return 'Bóng rổ';
      case 'tennis':
        return 'Tennis';
      case 'bong_chuyen':
        return 'Bóng chuyền';
      case 'bong_ban':
        return 'Bóng bàn';
      case 'chay_bo':
        return 'Chạy bộ';
      case 'dap_xe':
        return 'Đạp xe';
      case 'boi_loi':
        return 'Bơi lội';
      case 'yoga':
        return 'Yoga';
      case 'gym':
        return 'Gym';
      default:
        return sportType;
    }
  }

  String get skillLevelName {
    switch (skillLevel) {
      case 'moi_bat_dau':
        return 'Mới bắt đầu';
      case 'trung_binh':
        return 'Trung bình';
      case 'gioi':
        return 'Giỏi';
      case 'chuyen_nghiep':
        return 'Chuyên nghiệp';
      default:
        return skillLevel;
    }
  }

  String get privacyName {
    switch (privacy) {
      case 'cong_khai':
        return 'Công khai';
      case 'rieng_tu':
        return 'Riêng tư';
      default:
        return privacy;
    }
  }

  String get statusName {
    switch (status) {
      case 'hoat_dong':
        return 'Hoạt động';
      case 'tam_dung':
        return 'Tạm dừng';
      case 'dong_cua':
        return 'Đóng cửa';
      default:
        return status;
    }
  }

  bool get isFull => currentMembers >= maxMembers;
  bool get isActive => status == 'hoat_dong';
  bool get isPublic => privacy == 'cong_khai';

  static double? _convertToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}

class User {
  final int id;
  final String name;
  final String phone;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.phone,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Người dùng',
      phone: json['phone'] as String? ?? '',
      avatar: json['avatar'] as String?,
    );
  }
}

class GroupMember {
  final int userId;
  final String name;
  final String role;
  final String? avatar;
  final bool isCurrentUser;

  GroupMember({
    required this.userId,
    required this.name,
    required this.role,
    this.avatar,
    this.isCurrentUser = false,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      userId: (json['user_id'] ?? json['id'] ?? 0) as int,
      name: json['name'] as String? ?? 'Thành viên',
      role: (json['role'] ?? json['group_role'] ?? 'member') as String,
      avatar: json['avatar'] as String?,
      isCurrentUser: json['is_current_user'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'role': role,
      'avatar': avatar,
      'is_current_user': isCurrentUser,
    };
  }
}

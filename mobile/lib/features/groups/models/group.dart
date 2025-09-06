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
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      sportType: json['sport_type'] as String,
      skillLevel: json['skill_level'] as String,
      location: json['location'] as String,
      city: json['city'] as String,
      district: json['district'] as String?,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      schedule: json['schedule'] as Map<String, dynamic>?,
      maxMembers: json['max_members'] as int,
      currentMembers: json['current_members'] as int,
      membershipFee: (json['membership_fee'] as num?)?.toDouble() ?? 0.0,
      privacy: json['privacy'] as String,
      status: json['status'] as String,
      avatar: json['avatar'] as String?,
      rules: json['rules'] as Map<String, dynamic>?,
      creatorId: json['creator_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      activeMembers: json['active_members'] != null 
        ? (json['active_members'] as List).map((member) => User.fromJson(member)).toList()
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
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String?,
    );
  }
}
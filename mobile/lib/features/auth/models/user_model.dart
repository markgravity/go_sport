class UserModel {
  final int id;
  final String? firebaseUid;
  final String name;
  final String phone;
  final bool phoneVerified;
  final String? email;
  final Map<String, dynamic> preferences;
  final List<String> preferredSports;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    this.firebaseUid,
    required this.name,
    required this.phone,
    required this.phoneVerified,
    this.email,
    required this.preferences,
    this.preferredSports = const [],
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle preferred_sports as a separate field or from preferences
    List<String> sports = [];
    if (json['preferred_sports'] is List) {
      sports = (json['preferred_sports'] as List).cast<String>();
    } else {
      final prefs = json['preferences'] as Map<String, dynamic>? ?? {};
      if (prefs['sports'] is List) {
        sports = (prefs['sports'] as List).cast<String>();
      }
    }

    return UserModel(
      id: json['id'] as int,
      firebaseUid: json['firebase_uid'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String,
      phoneVerified: json['phone_verified'] as bool? ?? false,
      email: json['email'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>? ?? {},
      preferredSports: sports,
      status: json['status'] as String? ?? 'active',
      createdAt: json['created_at'] != null 
        ? DateTime.parse(json['created_at'] as String)
        : DateTime.now(),
      updatedAt: json['updated_at'] != null 
        ? DateTime.parse(json['updated_at'] as String) 
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firebase_uid': firebaseUid,
      'name': name,
      'phone': phone,
      'phone_verified': phoneVerified,
      'email': email,
      'preferences': preferences,
      'preferred_sports': preferredSports,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get locale {
    return preferences['language'] as String? ?? 'vi';
  }

  String get displayName {
    return name.isNotEmpty ? name : phone;
  }

  UserModel copyWith({
    int? id,
    String? firebaseUid,
    String? name,
    String? phone,
    bool? phoneVerified,
    String? email,
    Map<String, dynamic>? preferences,
    List<String>? preferredSports,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      email: email ?? this.email,
      preferences: preferences ?? this.preferences,
      preferredSports: preferredSports ?? this.preferredSports,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, phone: $phone, phoneVerified: $phoneVerified}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firebaseUid == other.firebaseUid;

  @override
  int get hashCode => id.hashCode ^ firebaseUid.hashCode;
}
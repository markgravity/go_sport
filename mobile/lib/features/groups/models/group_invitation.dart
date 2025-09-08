import 'group.dart';

class GroupInvitation {
  final int id;
  final int groupId;
  final int createdBy;
  final String token;
  final String type;
  final String status;
  final String? recipientPhone;
  final DateTime? expiresAt;
  final DateTime? usedAt;
  final int? usedBy;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Group? group;
  final User? creator;
  final User? usedByUser;

  GroupInvitation({
    required this.id,
    required this.groupId,
    required this.createdBy,
    required this.token,
    required this.type,
    required this.status,
    this.recipientPhone,
    this.expiresAt,
    this.usedAt,
    this.usedBy,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.group,
    this.creator,
    this.usedByUser,
  });

  factory GroupInvitation.fromJson(Map<String, dynamic> json) {
    return GroupInvitation(
      id: json['id'] as int,
      groupId: json['group_id'] as int,
      createdBy: json['created_by'] as int,
      token: json['token'] as String,
      type: json['type'] as String? ?? 'link',
      status: json['status'] as String? ?? 'pending',
      recipientPhone: json['recipient_phone'] as String?,
      expiresAt: json['expires_at'] != null 
          ? DateTime.parse(json['expires_at'] as String)
          : null,
      usedAt: json['used_at'] != null
          ? DateTime.parse(json['used_at'] as String)
          : null,
      usedBy: json['used_by'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      usedByUser: json['used_by_user'] != null ? User.fromJson(json['used_by_user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'created_by': createdBy,
      'token': token,
      'type': type,
      'status': status,
      'recipient_phone': recipientPhone,
      'expires_at': expiresAt?.toIso8601String(),
      'used_at': usedAt?.toIso8601String(),
      'used_by': usedBy,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get statusName {
    switch (status) {
      case 'pending':
        return 'Đang chờ';
      case 'used':
        return 'Đã sử dụng';
      case 'expired':
        return 'Hết hạn';
      case 'revoked':
        return 'Đã thu hồi';
      default:
        return status;
    }
  }

  String get typeName {
    switch (type) {
      case 'link':
        return 'Liên kết';
      default:
        return type;
    }
  }

  bool get isValid {
    return status == 'pending' && (expiresAt == null || expiresAt!.isAfter(DateTime.now()));
  }

  bool get isExpired {
    return expiresAt != null && expiresAt!.isBefore(DateTime.now());
  }

  String get invitationUrl => 'https://gosport.app/invite/$token';

  GroupInvitation copyWith({
    int? id,
    int? groupId,
    int? createdBy,
    String? token,
    String? type,
    String? status,
    String? recipientPhone,
    DateTime? expiresAt,
    DateTime? usedAt,
    int? usedBy,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    Group? group,
    User? creator,
    User? usedByUser,
  }) {
    return GroupInvitation(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      createdBy: createdBy ?? this.createdBy,
      token: token ?? this.token,
      type: type ?? this.type,
      status: status ?? this.status,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt ?? this.usedAt,
      usedBy: usedBy ?? this.usedBy,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      group: group ?? this.group,
      creator: creator ?? this.creator,
      usedByUser: usedByUser ?? this.usedByUser,
    );
  }
}

class GroupJoinRequest {
  final int id;
  final int groupId;
  final int userId;
  final int? invitationId;
  final String status;
  final String? message;
  final String? rejectionReason;
  final String source;
  final int? processedBy;
  final DateTime? processedAt;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Group? group;
  final User? user;
  final GroupInvitation? invitation;
  final User? processedByUser;

  GroupJoinRequest({
    required this.id,
    required this.groupId,
    required this.userId,
    this.invitationId,
    required this.status,
    this.message,
    this.rejectionReason,
    required this.source,
    this.processedBy,
    this.processedAt,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.group,
    this.user,
    this.invitation,
    this.processedByUser,
  });

  factory GroupJoinRequest.fromJson(Map<String, dynamic> json) {
    return GroupJoinRequest(
      id: json['id'] as int,
      groupId: json['group_id'] as int,
      userId: json['user_id'] as int,
      invitationId: json['invitation_id'] as int?,
      status: json['status'] as String? ?? 'pending',
      message: json['message'] as String?,
      rejectionReason: json['rejection_reason'] as String?,
      source: json['source'] as String? ?? 'direct',
      processedBy: json['processed_by'] as int?,
      processedAt: json['processed_at'] != null
          ? DateTime.parse(json['processed_at'] as String)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      invitation: json['invitation'] != null ? GroupInvitation.fromJson(json['invitation']) : null,
      processedByUser: json['processed_by_user'] != null ? User.fromJson(json['processed_by_user']) : null,
    );
  }

  String get statusName {
    switch (status) {
      case 'pending':
        return 'Đang chờ duyệt';
      case 'approved':
        return 'Đã duyệt';
      case 'rejected':
        return 'Đã từ chối';
      default:
        return status;
    }
  }

  String get sourceName {
    switch (source) {
      case 'direct':
        return 'Yêu cầu trực tiếp';
      case 'invitation':
        return 'Từ lời mời';
      case 'search':
        return 'Từ tìm kiếm';
      default:
        return source;
    }
  }

  bool get canBeProcessed => status == 'pending';
  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';

  GroupJoinRequest copyWith({
    int? id,
    int? groupId,
    int? userId,
    int? invitationId,
    String? status,
    String? message,
    String? rejectionReason,
    String? adminMessage,
    String? source,
    int? processedBy,
    DateTime? processedAt,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    Group? group,
    User? user,
    GroupInvitation? invitation,
    User? processedByUser,
  }) {
    return GroupJoinRequest(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      invitationId: invitationId ?? this.invitationId,
      status: status ?? this.status,
      message: message ?? this.message,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      source: source ?? this.source,
      processedBy: processedBy ?? this.processedBy,
      processedAt: processedAt ?? this.processedAt,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      group: group ?? this.group,
      user: user ?? this.user,
      invitation: invitation ?? this.invitation,
      processedByUser: processedByUser ?? this.processedByUser,
    );
  }
}
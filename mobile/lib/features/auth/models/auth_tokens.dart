class AuthTokens {
  final String firebaseIdToken;
  final String laravelToken;
  final String firebaseUid;
  final DateTime expiresAt;

  const AuthTokens({
    required this.firebaseIdToken,
    required this.laravelToken,
    required this.firebaseUid,
    required this.expiresAt,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    final tokens = json['tokens'] as Map<String, dynamic>;
    return AuthTokens(
      firebaseIdToken: json['firebase_id_token'] as String? ?? '',
      laravelToken: tokens['laravel_token'] as String,
      firebaseUid: tokens['firebase_uid'] as String,
      expiresAt: DateTime.now().add(const Duration(hours: 1)), // Default 1 hour
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firebase_id_token': firebaseIdToken,
      'tokens': {
        'laravel_token': laravelToken,
        'firebase_uid': firebaseUid,
      },
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  bool get isValid {
    return firebaseIdToken.isNotEmpty && 
           laravelToken.isNotEmpty && 
           firebaseUid.isNotEmpty && 
           !isExpired;
  }

  AuthTokens copyWith({
    String? firebaseIdToken,
    String? laravelToken,
    String? firebaseUid,
    DateTime? expiresAt,
  }) {
    return AuthTokens(
      firebaseIdToken: firebaseIdToken ?? this.firebaseIdToken,
      laravelToken: laravelToken ?? this.laravelToken,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  String toString() {
    return 'AuthTokens{firebaseUid: $firebaseUid, expired: $isExpired}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthTokens &&
          runtimeType == other.runtimeType &&
          firebaseUid == other.firebaseUid &&
          laravelToken == other.laravelToken;

  @override
  int get hashCode => firebaseUid.hashCode ^ laravelToken.hashCode;
}
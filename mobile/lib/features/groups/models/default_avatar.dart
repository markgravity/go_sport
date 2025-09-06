class DefaultAvatar {
  final String id;
  final String name;
  final String url;
  final String? sport;

  DefaultAvatar({
    required this.id,
    required this.name,
    required this.url,
    this.sport,
  });

  factory DefaultAvatar.fromJson(Map<String, dynamic> json) {
    return DefaultAvatar(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      sport: json['sport'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'sport': sport,
    };
  }

  bool matchesSport(String? sportType) {
    return sport == null || sport == sportType;
  }
}
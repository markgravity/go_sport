class Sport {
  final String key;
  final String name;
  final String englishName;
  final String icon;
  final SportDefaults defaults;
  final Map<String, String> skillLevels;

  Sport({
    required this.key,
    required this.name,
    required this.englishName,
    required this.icon,
    required this.defaults,
    required this.skillLevels,
  });

  factory Sport.fromJson(String key, Map<String, dynamic> json) {
    return Sport(
      key: key,
      name: json['vietnamese_name'] as String? ?? 'Chưa rõ',
      englishName: json['english_name'] as String? ?? 'Unknown',
      icon: json['icon'] as String? ?? 'sports',
      defaults: SportDefaults.fromJson(json['defaults'] ?? {}),
      skillLevels: {
        'moi_bat_dau': 'Mới bắt đầu',
        'trung_binh': 'Trung bình', 
        'gioi': 'Giỏi',
        'chuyen_nghiep': 'Chuyên nghiệp',
      },
    );
  }

  List<SkillLevel> get skillLevelsList {
    return skillLevels.entries.map((entry) => 
      SkillLevel(key: entry.key, name: entry.value)
    ).toList();
  }
}

class SportDefaults {
  final int maxMembers;
  final int minPlayers;
  final int maxPlayers;
  final int notificationHours;
  final int typicalDuration;
  final List<String> typicalLocations;
  final List<String> equipmentNeeded;

  SportDefaults({
    required this.maxMembers,
    required this.minPlayers,
    required this.maxPlayers,
    required this.notificationHours,
    required this.typicalDuration,
    required this.typicalLocations,
    required this.equipmentNeeded,
  });

  factory SportDefaults.fromJson(Map<String, dynamic>? json) {
    final data = json ?? {};
    return SportDefaults(
      maxMembers: data['max_players'] as int? ?? 20,
      minPlayers: data['min_players'] as int? ?? 2,
      maxPlayers: data['max_players'] as int? ?? 20,
      notificationHours: data['notification_hours'] as int? ?? 24,
      typicalDuration: data['typical_duration_minutes'] as int? ?? 60,
      typicalLocations: data['typical_locations'] != null 
          ? List<String>.from(data['typical_locations']) 
          : [],
      equipmentNeeded: [], // Not provided by our current API
    );
  }
}

class SkillLevel {
  final String key;
  final String name;

  SkillLevel({
    required this.key,
    required this.name,
  });
}

class SportCategory {
  final String name;
  final List<String> sports;

  SportCategory({
    required this.name,
    required this.sports,
  });

  factory SportCategory.fromJson(Map<String, dynamic> json) {
    return SportCategory(
      name: json['name'] as String,
      sports: List<String>.from(json['sports']),
    );
  }
}
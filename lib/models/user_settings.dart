enum LearningLanguage {
  spanish,
  french,
  german,
  // Add more languages as needed
}

extension LearningLanguageExtension on LearningLanguage {
  String get name {
    switch (this) {
      case LearningLanguage.spanish:
        return 'Spanish';
      case LearningLanguage.french:
        return 'French';
      case LearningLanguage.german:
        return 'German';
    }
  }
}

enum DailyGoal {
  casual, // 10 XP
  regular, // 30 XP
  intense, // 50 XP (example)
}

extension DailyGoalExtension on DailyGoal {
  String get name {
    switch (this) {
      case DailyGoal.casual:
        return 'Casual';
      case DailyGoal.regular:
        return 'Regular';
      case DailyGoal.intense:
        return 'Intense';
    }
  }

  int get xpPerDay {
    switch (this) {
      case DailyGoal.casual:
        return 10;
      case DailyGoal.regular:
        return 30;
      case DailyGoal.intense:
        return 50;
    }
  }
}

class UserSettings {
  LearningLanguage? selectedLanguage;
  DailyGoal? dailyGoal;

  UserSettings({this.selectedLanguage, this.dailyGoal});

  // For persistence (e.g., if you save this to SharedPreferences or a backend)
  Map<String, dynamic> toJson() => {
    'selectedLanguage': selectedLanguage?.name,
    'dailyGoal': dailyGoal?.name,
  };

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      selectedLanguage: _parseLanguage(json['selectedLanguage']),
      dailyGoal: _parseDailyGoal(json['dailyGoal']),
    );
  }

  static LearningLanguage? _parseLanguage(String? name) {
    if (name == null) return null;
    return LearningLanguage.values.firstWhere(
          (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => LearningLanguage.spanish, // Default or handle error
    );
  }

  static DailyGoal? _parseDailyGoal(String? name) {
    if (name == null) return null;
    return DailyGoal.values.firstWhere(
          (e) => e.name.toLowerCase() == name.toLowerCase(),
      orElse: () => DailyGoal.casual, // Default or handle error
    );
  }
}
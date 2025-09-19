import 'package:wardiooo/models/user_settings.dart';

// This would interact with SharedPreferences, a database, or an API
class UserSettingsService {
  UserSettings _currentUserSettings = UserSettings(); // In-memory mock

  Future<UserSettings> fetchUserSettings() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would load from storage/backend
    return _currentUserSettings;
  }

  Future<void> saveLanguage(LearningLanguage language) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUserSettings.selectedLanguage = language;
    print('Saved language: ${language.name}');
    // In a real app, save to storage/backend
  }

  Future<void> saveDailyGoal(DailyGoal goal) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUserSettings.dailyGoal = goal;
    print('Saved daily goal: ${goal.name}');
    // In a real app, save to storage/backend
  }

  // Potentially a method to save all settings at once
  Future<void> saveAllSettings(UserSettings settings) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUserSettings = settings;
    print('Saved all settings: ${settings.toJson()}');
  }
}
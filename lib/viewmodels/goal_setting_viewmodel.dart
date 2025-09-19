import 'package:flutter/material.dart';
import 'package:wardiooo/models/user_settings.dart';
import 'package:wardiooo/services/user_settings_service.dart';

class GoalSettingViewModel extends ChangeNotifier {
  final UserSettingsService _settingsService;

  DailyGoal? _selectedGoal;
  DailyGoal? get selectedGoal => _selectedGoal;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  GoalSettingViewModel(this._settingsService) {
    _loadInitialGoal();
  }

  Future<void> _loadInitialGoal() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final settings = await _settingsService.fetchUserSettings();
      _selectedGoal = settings.dailyGoal;
    } catch (e) {
      _errorMessage = 'Failed to load initial goal.';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedGoal(DailyGoal goal) {
    if (_selectedGoal != goal) {
      _selectedGoal = goal;
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<bool> saveDailyGoal() async {
    if (_selectedGoal == null) {
      _errorMessage = 'Please select a daily goal.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _settingsService.saveDailyGoal(_selectedGoal!);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save daily goal. Please try again.';
      print(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
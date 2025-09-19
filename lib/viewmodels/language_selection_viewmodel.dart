import 'package:flutter/material.dart';
import 'package:wardiooo/models/user_settings.dart';
import 'package:wardiooo/services/user_settings_service.dart';

class LanguageSelectionViewModel extends ChangeNotifier {
  final UserSettingsService _settingsService;

  LearningLanguage? _selectedLanguage;
  LearningLanguage? get selectedLanguage => _selectedLanguage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  LanguageSelectionViewModel(this._settingsService) {
    _loadInitialLanguage();
  }

  Future<void> _loadInitialLanguage() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final settings = await _settingsService.fetchUserSettings();
      _selectedLanguage = settings.selectedLanguage;
    } catch (e) {
      _errorMessage = 'Failed to load initial language.';
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedLanguage(LearningLanguage language) {
    if (_selectedLanguage != language) {
      _selectedLanguage = language;
      _errorMessage = null; // Clear previous errors
      notifyListeners();
    }
  }

  Future<bool> saveLanguage() async {
    if (_selectedLanguage == null) {
      _errorMessage = 'Please select a language.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _settingsService.saveLanguage(_selectedLanguage!);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to save language. Please try again.';
      print(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
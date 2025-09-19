import 'package:flutter/material.dart';
import 'package:wardiooo/models/user_settings.dart';
import 'package:wardiooo/viewmodels/goal_setting_viewmodel.dart';
import 'package:wardiooo/viewmodels/language_selection_viewmodel.dart';
import 'package:wardiooo/views/onboarding/language_selection_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We provide the UserSettingsService globally or at a high level
    // so that both ViewModels can access the same instance.
    return MultiProvider(
      providers: [
        Provider<UserSettingsService>(
          create: (_) => UserSettingsService(),
        ),
        ChangeNotifierProvider<LanguageSelectionViewModel>(
          create: (context) => LanguageSelectionViewModel(
            context.read<UserSettingsService>(),
          ),
        ),
        ChangeNotifierProvider<GoalSettingViewModel>(
          create: (context) => GoalSettingViewModel(
            context.read<UserSettingsService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'wardiooo Onboarding',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const LanguageSelectionScreen(), // Start the onboarding flow
      ),
    );
  }
}
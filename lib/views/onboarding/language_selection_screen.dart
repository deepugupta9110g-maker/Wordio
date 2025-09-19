import 'package:flutter/material.dart';
import 'package:wardiooo/models/user_settings.dart';
import 'package:wardiooo/viewmodels/language_selection_viewmodel.dart';
import 'package:wardiooo/views/onboarding/goal_setting_screen.dart';
import 'package:provider/provider.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Language')),
      body: Consumer<LanguageSelectionViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What language do you want to learn?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: LearningLanguage.values.length,
                    itemBuilder: (context, index) {
                      final language = LearningLanguage.values[index];
                      return RadioListTile<LearningLanguage>(
                        title: Text(language.name),
                        value: language,
                        groupValue: viewModel.selectedLanguage,
                        onChanged: (value) {
                          if (value != null) {
                            viewModel.setSelectedLanguage(value);
                          }
                        },
                      );
                    },
                  ),
                ),
                if (viewModel.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      viewModel.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool success = await viewModel.saveLanguage();
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const GoalSettingScreen()),
                        );
                      } else {
                        // Optionally show a SnackBar for error, as error message is also displayed.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(viewModel.errorMessage!)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Next', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
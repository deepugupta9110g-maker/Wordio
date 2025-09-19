import 'package:flutter/material.dart';
import 'package:wardiooo/models/user_settings.dart';
import 'package:wardiooo/viewmodels/goal_setting_viewmodel.dart';
import 'package:provider/provider.dart';

class GoalSettingScreen extends StatelessWidget {
  const GoalSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Daily Goal')),
      body: Consumer<GoalSettingViewModel>(
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
                  'Set your daily learning goal:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: DailyGoal.values.length,
                    itemBuilder: (context, index) {
                      final goal = DailyGoal.values[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        child: RadioListTile<DailyGoal>(
                          title: Text(goal.name),
                          subtitle: Text('${goal.xpPerDay} XP per day'),
                          value: goal,
                          groupValue: viewModel.selectedGoal,
                          onChanged: (value) {
                            if (value != null) {
                              viewModel.setSelectedGoal(value);
                            }
                          },
                          secondary: Icon(
                            goal == DailyGoal.casual
                                ? Icons.brightness_low
                                : goal == DailyGoal.regular
                                ? Icons.brightness_medium
                                : Icons.brightness_high,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
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
                      bool success = await viewModel.saveDailyGoal();
                      if (success) {
                        // Onboarding complete, navigate to main app screen
                        // For now, let's just pop or navigate to a placeholder
                        Navigator.popUntil(context, (route) => route.isFirst); // Go back to root
                        // In a real app, you'd navigate to your main dashboard screen.
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainAppScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Onboarding Complete!')),
                        );
                      } else {
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
                        : const Text('Finish Onboarding', style: TextStyle(fontSize: 18)),
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
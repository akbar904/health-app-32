import 'package:flutter/material.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.runStartupLogic(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/steve.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              if (model.hasError)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'An error occurred while starting the app',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

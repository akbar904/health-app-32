import 'package:flutter/material.dart';
import 'package:my_app/features/startup/startup_viewmodel.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.runStartupLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'MyApp',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: kcPrimaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              if (model.isBusy)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(kcPrimaryColor),
                  ),
                )
              else if (model.hasModelError)
                Text(
                  model.modelError.toString(),
                  style: const TextStyle(
                    color: kcErrorRed,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

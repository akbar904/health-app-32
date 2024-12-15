import 'package:flutter/material.dart';
import 'package:my_app/features/auth/register_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kcTextPrimary,
                      ),
                    ),
                    const Text(
                      'Please fill in the details below',
                      style: TextStyle(
                        fontSize: 16,
                        color: kcTextSecondary,
                      ),
                    ),
                    verticalSpaceLarge,
                    AuthTextField(
                      label: 'Full Name',
                      controller: model.nameController,
                      validator: model.validateName,
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    verticalSpaceMedium,
                    AuthTextField(
                      label: 'Email Address',
                      controller: model.emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: model.validateEmail,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    verticalSpaceMedium,
                    AuthTextField(
                      label: 'Password',
                      controller: model.passwordController,
                      obscureText: true,
                      validator: model.validatePassword,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    verticalSpaceLarge,
                    AuthButton(
                      text: 'Create Account',
                      onPressed: model.register,
                      isLoading: model.isBusy,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: kcTextSecondary),
                        ),
                        TextButton(
                          onPressed: model.navigateToLogin,
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                    if (model.hasModelError)
                      errorMessageWidget(model.modelError.toString()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

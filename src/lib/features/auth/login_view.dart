import 'package:flutter/material.dart';
import 'package:my_app/features/auth/login_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';
import 'package:my_app/ui/common/app_colors.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: kcTextPrimary,
                      ),
                    ),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: kcTextSecondary,
                      ),
                    ),
                    verticalSpaceLarge,
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
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                    ),
                    verticalSpaceLarge,
                    AuthButton(
                      text: 'Sign In',
                      onPressed: model.login,
                      isLoading: model.isBusy,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: kcTextSecondary),
                        ),
                        TextButton(
                          onPressed: model.navigateToRegister,
                          child: const Text('Sign Up'),
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

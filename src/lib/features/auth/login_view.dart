import 'package:flutter/material.dart';
import 'package:my_app/features/auth/login_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceMedium,
                  AuthTextField(
                    label: 'Email',
                    controller: model.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: model.validateEmail,
                  ),
                  verticalSpaceMedium,
                  AuthTextField(
                    label: 'Password',
                    controller: model.passwordController,
                    obscureText: true,
                    validator: model.validatePassword,
                  ),
                  verticalSpaceLarge,
                  AuthButton(
                    text: 'Login',
                    onPressed: model.login,
                    isLoading: model.isBusy,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: model.navigateToRegister,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                  if (model.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        model.error.toString(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

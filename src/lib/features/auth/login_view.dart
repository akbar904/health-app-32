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
          child: SingleChildScrollView(
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
                    enabled: !model.isBusy,
                  ),
                  verticalSpaceMedium,
                  AuthTextField(
                    label: 'Password',
                    controller: model.passwordController,
                    obscureText: true,
                    validator: model.validatePassword,
                    enabled: !model.isBusy,
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
                        onPressed:
                            model.isBusy ? null : model.navigateToRegister,
                        child: const Text('Register'),
                      ),
                    ],
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

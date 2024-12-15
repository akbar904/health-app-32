import 'package:flutter/material.dart';
import 'package:my_app/features/auth/register_viewmodel.dart';
import 'package:my_app/features/auth/widgets/auth_button.dart';
import 'package:my_app/features/auth/widgets/auth_text_field.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
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
                    'Register',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpaceMedium,
                  AuthTextField(
                    label: 'Name',
                    controller: model.nameController,
                    validator: model.validateName,
                    enabled: !model.isBusy,
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
                    text: 'Register',
                    onPressed: model.register,
                    isLoading: model.isBusy,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? '),
                      TextButton(
                        onPressed: model.isBusy ? null : model.navigateToLogin,
                        child: const Text('Login'),
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

import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/common/password_field.dart';
import 'package:my_app/ui/widgets/common/primary_button.dart';
import 'package:my_app/ui/widgets/common/text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: model.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  labelText: 'Email',
                  controller: model.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: model.validateEmail,
                ),
                const SizedBox(height: 16),
                AppPasswordField(
                  labelText: 'Password',
                  controller: model.passwordController,
                  validator: model.validatePassword,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  text: 'Login',
                  onPressed: model.login,
                  busy: model.isBusy,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: model.navigateToRegister,
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

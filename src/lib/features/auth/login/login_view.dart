import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/auth_button.dart';
import 'package:my_app/ui/widgets/auth_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/login/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                controller: model.emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              AuthTextField(
                controller: model.passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              AuthButton(
                title: 'Login',
                onTap: model.login,
                isLoading: model.isBusy,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: model.navigateToRegister,
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

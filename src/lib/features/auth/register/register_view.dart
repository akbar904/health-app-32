import 'package:flutter/material.dart';
import 'package:my_app/ui/widgets/auth_button.dart';
import 'package:my_app/ui/widgets/auth_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/register/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
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
              const SizedBox(height: 20),
              AuthTextField(
                controller: model.confirmPasswordController,
                labelText: 'Confirm Password',
                hintText: 'Confirm your password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              AuthButton(
                title: 'Register',
                onTap: model.register,
                isLoading: model.isBusy,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: model.navigateToLogin,
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

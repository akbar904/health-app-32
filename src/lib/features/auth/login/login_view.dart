import 'package:flutter/material.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: model.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpaceMedium,
              TextField(
                controller: model.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              verticalSpaceMedium,
              if (model.hasError)
                Text(
                  model.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              verticalSpaceMedium,
              ElevatedButton(
                onPressed: model.isBusy ? null : model.login,
                child: model.isBusy
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
              verticalSpaceMedium,
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

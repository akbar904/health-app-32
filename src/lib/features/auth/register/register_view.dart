import 'package:flutter/material.dart';
import 'package:my_app/ui/common/ui_helpers.dart';
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: model.nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceMedium,
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
                onPressed: model.isBusy ? null : model.register,
                child: model.isBusy
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
              verticalSpaceMedium,
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

import 'package:flutter/material.dart';
import 'package:my_app/features/auth/register/register_viewmodel.dart';
import 'package:my_app/ui/widgets/common/password_field.dart';
import 'package:my_app/ui/widgets/common/primary_button.dart';
import 'package:my_app/ui/widgets/common/text_field.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
          child: Form(
            key: model.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  labelText: 'Name',
                  controller: model.nameController,
                  validator: model.validateName,
                ),
                const SizedBox(height: 16),
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
                  text: 'Register',
                  onPressed: model.register,
                  busy: model.isBusy,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: model.navigateToLogin,
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

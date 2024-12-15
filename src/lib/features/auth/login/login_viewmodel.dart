import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      setBusy(true);
      await _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to login. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  void navigateToRegister() {
    _navigationService.navigateToRegisterView();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

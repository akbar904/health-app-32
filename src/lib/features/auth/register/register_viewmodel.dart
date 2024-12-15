import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void navigateToLogin() {
    _navigationService.replaceWithLoginView();
  }

  Future<void> register() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Please fill in all fields',
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Passwords do not match',
      );
      return;
    }

    try {
      setBusy(true);
      await _authService.register(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

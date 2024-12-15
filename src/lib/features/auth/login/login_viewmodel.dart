import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void navigateToRegister() {
    _navigationService.replaceWithRegisterView();
  }

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Please fill in all fields',
      );
      return;
    }

    try {
      setBusy(true);
      await _authService.login(
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
    super.dispose();
  }
}

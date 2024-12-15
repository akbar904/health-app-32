import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

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

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      setBusy(true);
      await _authRepository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to register. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  void navigateToLogin() {
    _navigationService.navigateToLoginView();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

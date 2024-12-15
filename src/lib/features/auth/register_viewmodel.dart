import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

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
      return 'Please enter a valid email address';
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
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      await _navigationService.replaceWithHomeView();
    } catch (e) {
      String errorMessage = 'Unable to create account. Please try again.';

      if (e.toString().contains('email-already-in-use')) {
        errorMessage =
            'An account already exists with this email address. Please try logging in instead.';
      } else if (e.toString().contains('invalid-email')) {
        errorMessage = 'Please enter a valid email address.';
      } else if (e.toString().contains('weak-password')) {
        errorMessage =
            'Please choose a stronger password. It should be at least 6 characters long.';
      } else if (e.toString().contains('network')) {
        errorMessage =
            'Network error. Please check your internet connection and try again.';
      }

      setError(errorMessage);
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

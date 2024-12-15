import 'package:flutter/material.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:my_app/utils/exceptions/auth_exception.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _authRepository = locator<AuthRepository>();
  final _navigationService = locator<NavigationService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get hasError => _errorMessage != null;

  Future<void> register() async {
    try {
      setBusy(true);
      _errorMessage = null;

      await _authRepository.register(
        emailController.text.trim(),
        passwordController.text,
        nameController.text.trim(),
      );

      await _navigationService.clearStackAndShow(Routes.homeView);
    } on AuthException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      notifyListeners();
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

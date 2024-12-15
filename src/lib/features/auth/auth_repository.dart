import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:my_app/utils/exceptions/api_exception.dart';

class AuthRepository {
  final _authService = locator<AuthService>();

  Future<User> login(String email, String password) async {
    try {
      return await _authService.login(email, password);
    } catch (e) {
      if (e.toString().contains('invalid-email')) {
        throw ValidationException('The email address is not valid.');
      }
      if (e.toString().contains('user-not-found')) {
        throw AuthenticationException('No account found with this email.');
      }
      if (e.toString().contains('wrong-password')) {
        throw AuthenticationException('Incorrect password.');
      }
      if (e.toString().contains('too-many-requests')) {
        throw APIException(
          userMessage: 'Too many failed attempts. Please try again later.',
          errorCode: 'RATE_LIMIT',
        );
      }
      throw APIException(
        userMessage: 'Login failed. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'AUTH_ERROR',
      );
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      return await _authService.register(email, password, name);
    } catch (e) {
      if (e.toString().contains('email-already-in-use')) {
        throw ValidationException('An account already exists with this email.');
      }
      if (e.toString().contains('weak-password')) {
        throw ValidationException('The password provided is too weak.');
      }
      if (e.toString().contains('invalid-email')) {
        throw ValidationException('The email address is not valid.');
      }
      throw APIException(
        userMessage: 'Registration failed. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'AUTH_ERROR',
      );
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw APIException(
        userMessage: 'Unable to log out. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'AUTH_ERROR',
      );
    }
  }

  bool isAuthenticated() {
    return _authService.isAuthenticated();
  }

  User? get currentUser => _authService.currentUser;
}

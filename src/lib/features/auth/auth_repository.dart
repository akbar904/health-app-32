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
      throw APIException.fromAuthError(e.toString());
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      return await _authService.register(email, password, name);
    } catch (e) {
      throw APIException.fromAuthError(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw const APIException(
        message: 'Unable to sign out. Please try again.',
      );
    }
  }

  bool isAuthenticated() {
    return _authService.isAuthenticated();
  }

  User? get currentUser => _authService.currentUser;
}

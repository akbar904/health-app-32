import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_service.dart';

class AuthRepository {
  final _authService = locator<AuthService>();

  Future<User> login(String email, String password) {
    return _authService.login(email, password);
  }

  Future<User> register(String email, String password, String name) {
    return _authService.register(email, password, name);
  }

  Future<void> logout() {
    return _authService.logout();
  }

  bool isAuthenticated() {
    return _authService.isAuthenticated();
  }

  User? get currentUser => _authService.currentUser;
}

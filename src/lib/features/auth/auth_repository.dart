import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_service.dart';

class AuthRepository {
  final _authService = locator<AuthService>();

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    await _authService.register(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _authService.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  bool isAuthenticated() {
    return _authService.isAuthenticated();
  }

  User? get currentUser => _authService.currentUser;
}

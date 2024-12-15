import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<User> login(String email, String password) async {
    return _authService.login(email, password);
  }

  Future<User> register(String email, String password, String name) async {
    return _authService.register(email, password, name);
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  bool get isAuthenticated => _authService.isAuthenticated;

  User? get currentUser => _authService.currentUser;
}

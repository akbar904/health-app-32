import 'package:my_app/models/user.dart';
import 'package:my_app/services/appwrite_service.dart';
import 'package:my_app/services/shared_preferences_service.dart';
import 'package:my_app/utils/exceptions/auth_exception.dart';

class AuthService {
  final AppwriteService _appwriteService;
  final SharedPreferencesService _prefsService;

  AuthService(this._appwriteService, this._prefsService);

  Future<User> login(String email, String password) async {
    try {
      final session = await _appwriteService.createEmailSession(
        email: email,
        password: password,
      );

      final user = User(
        id: session.$id,
        email: email,
        name: email.split('@').first, // Temporary name from email
      );

      await _prefsService.saveUser(user);
      await _prefsService.saveAuthToken(session.$id);

      return user;
    } catch (e) {
      throw InvalidCredentialsException();
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      await _appwriteService.createAccount(
        email: email,
        password: password,
        name: name,
      );

      return login(email, password);
    } catch (e) {
      if (e.toString().contains('already exists')) {
        throw EmailAlreadyInUseException();
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final token = _prefsService.getAuthToken();
    if (token != null) {
      await _appwriteService.deleteSession(token);
    }
    await _prefsService.clearAuth();
  }

  bool get isAuthenticated => _prefsService.isUserLoggedIn;

  User? get currentUser => _prefsService.getUser();
}

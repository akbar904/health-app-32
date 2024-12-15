import 'package:appwrite/appwrite.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/shared_preferences_service.dart';

class AuthService {
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  late final Client _client;
  late final Account _account;

  AuthService() {
    _client = Client()
      ..setEndpoint('YOUR_APPWRITE_ENDPOINT')
      ..setProject('YOUR_PROJECT_ID');
    _account = Account(_client);
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );

      await _sharedPreferencesService.setUserId(result.$id);
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      await _sharedPreferencesService.setAuthToken(session.userId);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      await _sharedPreferencesService.setAuthToken(session.userId);
      await _sharedPreferencesService.setUserId(session.userId);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      await _sharedPreferencesService.clearAuth();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = _sharedPreferencesService.getAuthToken();
    return token != null;
  }
}

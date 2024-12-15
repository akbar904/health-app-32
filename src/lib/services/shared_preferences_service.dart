import 'package:shared_preferences.dart';

class SharedPreferencesService {
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setAuthToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }

  String? getAuthToken() {
    return _prefs.getString(tokenKey);
  }

  Future<void> setUserId(String userId) async {
    await _prefs.setString(userIdKey, userId);
  }

  String? getUserId() {
    return _prefs.getString(userIdKey);
  }

  Future<void> clearAuth() async {
    await _prefs.remove(tokenKey);
    await _prefs.remove(userIdKey);
  }
}

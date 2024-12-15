import 'dart:convert';
import 'package:shared_preferences.dart';
import 'package:my_app/models/user.dart';

class SharedPreferencesService {
  static const String keyUser = 'user';
  static const String keyAuthToken = 'authToken';

  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveUser(User user) async {
    await _prefs.setString(keyUser, jsonEncode(user.toJson()));
  }

  User? getUser() {
    final userJson = _prefs.getString(keyUser);
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }

  Future<void> saveAuthToken(String token) async {
    await _prefs.setString(keyAuthToken, token);
  }

  String? getAuthToken() {
    return _prefs.getString(keyAuthToken);
  }

  Future<void> clearAuth() async {
    await _prefs.remove(keyUser);
    await _prefs.remove(keyAuthToken);
  }

  bool get isUserLoggedIn => getAuthToken() != null;
}

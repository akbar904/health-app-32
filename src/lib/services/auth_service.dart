import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class AuthService implements InitializableDependency {
  static const String userKey = 'user_key';
  late final Client client;
  late final Account account;
  late final SharedPreferences _prefs;

  User? _currentUser;
  User? get currentUser => _currentUser;

  @override
  Future<void> init() async {
    client = Client()
      ..setEndpoint('YOUR_ENDPOINT')
      ..setProject('YOUR_PROJECT_ID');

    account = Account(client);
    _prefs = await SharedPreferences.getInstance();
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final userJson = _prefs.getString(userKey);
    if (userJson != null) {
      _currentUser = User.fromJson(jsonDecode(userJson));
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    await _prefs.setString(userKey, jsonEncode(user.toJson()));
    _currentUser = user;
  }

  Future<User> login(String email, String password) async {
    try {
      final session = await account.createEmailSession(
        email: email,
        password: password,
      );

      final user = User(
        id: session.userId,
        email: email,
        name: email.split('@')[0], // Default name from email
      );

      await _saveUserToPrefs(user);
      return user;
    } catch (e) {
      throw Exception('Failed to login: ${e.toString()}');
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      final response = await account.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      );

      final user = User(
        id: response.$id,
        email: email,
        name: name,
      );

      await _saveUserToPrefs(user);
      return user;
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await _prefs.remove(userKey);
      _currentUser = null;
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }
}

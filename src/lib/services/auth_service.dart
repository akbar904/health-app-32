import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:my_app/models/user.dart';
import 'package:shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

class AuthService implements InitializableDependency {
  late final Client client;
  late final Account account;
  late final SharedPreferences _prefs;
  static const String userKey = 'user_key';

  User? _currentUser;
  User? get currentUser => _currentUser;

  @override
  Future<void> init() async {
    client = Client()
      ..setEndpoint('YOUR_ENDPOINT') // Set your Appwrite endpoint
      ..setProject('YOUR_PROJECT_ID'); // Set your project ID

    account = Account(client);
    _prefs = await SharedPreferences.getInstance();
    _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final userJson = _prefs.getString(userKey);
    if (userJson != null) {
      _currentUser = User.fromJson(json.decode(userJson));
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    await _prefs.setString(userKey, json.encode(user.toJson()));
    _currentUser = user;
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await account.createEmailSession(
        email: email,
        password: password,
      );

      final response = await account.get();
      final user = User(
        id: response.$id,
        email: response.email,
        name: response.name,
      );

      await _saveUserToPrefs(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await _prefs.remove(userKey);
      _currentUser = null;
    } catch (e) {
      rethrow;
    }
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }
}

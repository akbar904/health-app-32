import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/utils/const/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      ..setEndpoint(appwriteEndpoint)
      ..setProject(appwriteProjectId)
      ..setSelfSigned(status: true);

    account = Account(client);
    _prefs = await SharedPreferences.getInstance();
    await _loadUserFromPrefs();
  }

  Future<void> _loadUserFromPrefs() async {
    final userJson = _prefs.getString(userKey);
    if (userJson != null) {
      try {
        final Map<String, dynamic> jsonMap =
            json.decode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(jsonMap);
      } catch (e) {
        await _prefs.remove(userKey);
        _currentUser = null;
      }
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

      final accountDetails = await account.get();

      final user = User(
        id: accountDetails.$id,
        email: email,
        name: accountDetails.name,
      );

      await _saveUserToPrefs(user);
      return user;
    } on AppwriteException catch (e) {
      String message;
      switch (e.code) {
        case 401:
          message = 'Invalid email or password. Please try again.';
          break;
        case 429:
          message = 'Too many login attempts. Please try again later.';
          break;
        case 503:
          message = 'Service temporarily unavailable. Please try again later.';
          break;
        default:
          message =
              'Login failed. Please check your credentials and try again.';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception('An unexpected error occurred. Please try again later.');
    }
  }

  Future<User> register(String email, String password, String name) async {
    try {
      final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      final newUser = User(
        id: user.$id,
        email: email,
        name: name,
      );

      await _saveUserToPrefs(newUser);
      return newUser;
    } on AppwriteException catch (e) {
      String message;
      switch (e.code) {
        case 400:
          if (e.message.contains('password')) {
            message = 'Password must be at least 8 characters long.';
          } else if (e.message.contains('email')) {
            message = 'Please enter a valid email address.';
          } else {
            message =
                'Invalid registration details. Please check and try again.';
          }
          break;
        case 409:
          message = 'An account with this email already exists.';
          break;
        case 429:
          message = 'Too many attempts. Please try again later.';
          break;
        default:
          message = 'Registration failed. Please try again later.';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception(
          'An unexpected error occurred during registration. Please try again later.');
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await _prefs.remove(userKey);
      _currentUser = null;
    } on AppwriteException catch (e) {
      String message;
      switch (e.code) {
        case 401:
          message = 'Session has expired. Please login again.';
          break;
        case 404:
          message = 'Session not found.';
          break;
        default:
          message = 'Logout failed. Please try again.';
      }
      throw Exception(message);
    } catch (e) {
      throw Exception(
          'An unexpected error occurred during logout. Please try again.');
    }
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }
}

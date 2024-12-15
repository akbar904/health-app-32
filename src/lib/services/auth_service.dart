import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/utils/exceptions/api_exception.dart';
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
    try {
      client = Client()
        ..setEndpoint('YOUR_ENDPOINT')
        ..setProject('YOUR_PROJECT_ID');

      account = Account(client);
      _prefs = await SharedPreferences.getInstance();
      await _loadUserFromPrefs();
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to initialize authentication service.',
        technicalDetails: e.toString(),
        errorCode: 'INIT_ERROR',
      );
    }
  }

  Future<void> _loadUserFromPrefs() async {
    try {
      final userJson = _prefs.getString(userKey);
      if (userJson != null) {
        final Map<String, dynamic> jsonMap =
            json.decode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(jsonMap);
      }
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to load user data.',
        technicalDetails: e.toString(),
        errorCode: 'LOAD_USER_ERROR',
      );
    }
  }

  Future<void> _saveUserToPrefs(User user) async {
    try {
      await _prefs.setString(userKey, jsonEncode(user.toJson()));
      _currentUser = user;
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to save user data.',
        technicalDetails: e.toString(),
        errorCode: 'SAVE_USER_ERROR',
      );
    }
  }

  Future<User> login(String email, String password) async {
    try {
      final session = await account.createEmailSession(
        email: email,
        password: password,
      );

      final user = User(
        id: session.$id,
        email: email,
        name: email.split('@')[0],
      );

      await _saveUserToPrefs(user);
      return user;
    } on AppwriteException catch (e) {
      throw APIException(
        userMessage: _getAppwriteErrorMessage(e),
        technicalDetails: e.toString(),
        errorCode: e.code ?? 'LOGIN_ERROR',
      );
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to log in. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'LOGIN_ERROR',
      );
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
    } on AppwriteException catch (e) {
      throw APIException(
        userMessage: _getAppwriteErrorMessage(e),
        technicalDetails: e.toString(),
        errorCode: e.code ?? 'REGISTER_ERROR',
      );
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to create account. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'REGISTER_ERROR',
      );
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      await _prefs.remove(userKey);
      _currentUser = null;
    } on AppwriteException catch (e) {
      throw APIException(
        userMessage: _getAppwriteErrorMessage(e),
        technicalDetails: e.toString(),
        errorCode: e.code ?? 'LOGOUT_ERROR',
      );
    } catch (e) {
      throw APIException(
        userMessage: 'Failed to log out. Please try again.',
        technicalDetails: e.toString(),
        errorCode: 'LOGOUT_ERROR',
      );
    }
  }

  bool isAuthenticated() {
    return _currentUser != null;
  }

  String _getAppwriteErrorMessage(AppwriteException e) {
    switch (e.code) {
      case 401:
        return 'Invalid email or password.';
      case 404:
        return 'Account not found.';
      case 409:
        return 'An account with this email already exists.';
      case 429:
        return 'Too many attempts. Please try again later.';
      case 503:
        return 'Service temporarily unavailable. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}

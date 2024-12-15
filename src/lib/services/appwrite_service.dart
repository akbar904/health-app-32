import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static const String projectId = 'your-project-id';
  static const String endpoint = 'your-endpoint';

  late final Client client;
  late final Account account;
  late final Databases databases;

  AppwriteService() {
    client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: true); // For development only

    account = Account(client);
    databases = Databases(client);
  }

  Future<void> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<Session> createEmailSession({
    required String email,
    required String password,
  }) async {
    try {
      return await account.createEmailSession(
        email: email,
        password: password,
      );
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Future<void> deleteSession(String sessionId) async {
    try {
      await account.deleteSession(sessionId: sessionId);
    } catch (e) {
      throw _handleAppwriteError(e);
    }
  }

  Exception _handleAppwriteError(dynamic error) {
    if (error is AppwriteException) {
      switch (error.type) {
        case 'user_already_exists':
          return Exception('Email already exists');
        case 'user_invalid_credentials':
          return Exception('Invalid credentials');
        default:
          return Exception(error.message);
      }
    }
    return Exception('An unexpected error occurred');
  }
}

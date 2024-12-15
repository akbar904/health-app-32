import 'package:appwrite/appwrite.dart';
import 'package:my_app/models/user.dart';

class AuthRepository {
  late final Client _client;
  late final Account _account;
  late final Databases _databases;

  AuthRepository() {
    _client = Client()
      ..setEndpoint('YOUR_APPWRITE_ENDPOINT')
      ..setProject('YOUR_PROJECT_ID');
    _account = Account(_client);
    _databases = Databases(_client);
  }

  Future<User> getUserProfile(String userId) async {
    try {
      final document = await _databases.getDocument(
        databaseId: 'YOUR_DATABASE_ID',
        collectionId: 'users',
        documentId: userId,
      );
      return User.fromJson(document.data);
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  Future<void> updateUserProfile(User user) async {
    try {
      await _databases.updateDocument(
        databaseId: 'YOUR_DATABASE_ID',
        collectionId: 'users',
        documentId: user.id,
        data: user.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }
}

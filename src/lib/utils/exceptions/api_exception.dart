/// Custom exception class for API-related errors with user-friendly messages
class APIException implements Exception {
  final String message;
  final String? technicalDetails;

  const APIException({
    required this.message,
    this.technicalDetails,
  });

  @override
  String toString() {
    return message;
  }

  /// Factory constructor for common authentication errors
  factory APIException.fromAuthError(String error) {
    switch (error.toLowerCase()) {
      case 'user-not-found':
        return const APIException(
          message:
              'No account found with this email address. Please check your email or create a new account.',
          technicalDetails: 'user-not-found',
        );
      case 'wrong-password':
        return const APIException(
          message: 'Incorrect password. Please try again.',
          technicalDetails: 'wrong-password',
        );
      case 'email-already-in-use':
        return const APIException(
          message:
              'An account already exists with this email address. Please try logging in instead.',
          technicalDetails: 'email-already-in-use',
        );
      case 'invalid-email':
        return const APIException(
          message: 'Please enter a valid email address.',
          technicalDetails: 'invalid-email',
        );
      case 'weak-password':
        return const APIException(
          message:
              'Please choose a stronger password. It should be at least 6 characters long.',
          technicalDetails: 'weak-password',
        );
      case 'network-error':
        return const APIException(
          message:
              'Network error. Please check your internet connection and try again.',
          technicalDetails: 'network-error',
        );
      default:
        return APIException(
          message: 'An unexpected error occurred. Please try again.',
          technicalDetails: error,
        );
    }
  }
}

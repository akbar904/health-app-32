class APIException implements Exception {
  final String userMessage;
  final String? technicalDetails;
  final String errorCode;

  const APIException({
    required this.userMessage,
    this.technicalDetails,
    this.errorCode = 'UNKNOWN',
  });

  @override
  String toString() => userMessage;

  Map<String, dynamic> toMap() {
    return {
      'userMessage': userMessage,
      'technicalDetails': technicalDetails,
      'errorCode': errorCode,
    };
  }
}

class AuthenticationException extends APIException {
  AuthenticationException([String? message])
      : super(
          userMessage: message ?? 'Authentication failed. Please try again.',
          errorCode: 'AUTH_ERROR',
        );
}

class NetworkException extends APIException {
  NetworkException([String? message])
      : super(
          userMessage: message ??
              'Unable to connect to the server. Please check your internet connection.',
          errorCode: 'NETWORK_ERROR',
        );
}

class ValidationException extends APIException {
  ValidationException([String? message])
      : super(
          userMessage: message ?? 'Please check your input and try again.',
          errorCode: 'VALIDATION_ERROR',
        );
}

class ServerException extends APIException {
  ServerException([String? message])
      : super(
          userMessage: message ??
              'We encountered an unexpected error. Please try again later.',
          errorCode: 'SERVER_ERROR',
        );
}

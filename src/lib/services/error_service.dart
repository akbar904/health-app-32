import 'package:my_app/utils/exceptions/api_exception.dart';
import 'package:flutter/foundation.dart';

class ErrorService {
  void logError(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print('Error: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }

    // TODO: Implement production error logging service
    // This could be Firebase Crashlytics, Sentry, etc.
  }

  String getErrorMessage(dynamic error) {
    if (error is APIException) {
      return error.userMessage;
    }

    if (error is String) {
      return error;
    }

    return 'An unexpected error occurred. Please try again later.';
  }

  void handleError(dynamic error, StackTrace? stackTrace) {
    logError(error, stackTrace);

    if (error is APIException) {
      // Handle specific API exceptions
      switch (error.errorCode) {
        case 'AUTH_ERROR':
          // Handle authentication errors
          break;
        case 'NETWORK_ERROR':
          // Handle network errors
          break;
        case 'VALIDATION_ERROR':
          // Handle validation errors
          break;
        case 'SERVER_ERROR':
          // Handle server errors
          break;
      }
    }
  }

  bool isNetworkError(dynamic error) {
    return error is NetworkException ||
        error.toString().contains('SocketException') ||
        error.toString().contains('TimeoutException');
  }

  bool isAuthenticationError(dynamic error) {
    return error is AuthenticationException ||
        error.toString().contains('unauthorized') ||
        error.toString().contains('forbidden');
  }
}

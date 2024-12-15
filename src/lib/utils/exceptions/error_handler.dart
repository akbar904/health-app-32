import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:my_app/services/error_service.dart';
import 'package:my_app/utils/exceptions/api_exception.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is AuthenticationException) {
      return error.userMessage;
    }

    if (error is ValidationException) {
      return error.userMessage;
    }

    if (error is NetworkException) {
      return error.userMessage;
    }

    if (error is ServerException) {
      return error.userMessage;
    }

    if (error is SocketException) {
      return 'Unable to connect to the server. Please check your internet connection.';
    }

    if (error is TimeoutException) {
      return 'The request timed out. Please try again.';
    }

    if (error is PlatformException) {
      return 'An error occurred with the app. Please try again.';
    }

    if (error is FormatException) {
      return 'Invalid data received from the server. Please try again later.';
    }

    // Default error message for unknown errors
    return 'An unexpected error occurred. Please try again later.';
  }

  static String handleLoginError(dynamic error) {
    if (error.toString().contains('invalid-email')) {
      return 'The email address is invalid.';
    }

    if (error.toString().contains('user-not-found')) {
      return 'No user found with this email.';
    }

    if (error.toString().contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    }

    if (error.toString().contains('user-disabled')) {
      return 'This account has been disabled.';
    }

    return handleError(error);
  }

  static String handleRegistrationError(dynamic error) {
    if (error.toString().contains('email-already-in-use')) {
      return 'An account already exists with this email.';
    }

    if (error.toString().contains('weak-password')) {
      return 'The password provided is too weak.';
    }

    if (error.toString().contains('invalid-email')) {
      return 'The email address is invalid.';
    }

    return handleError(error);
  }

  static String handleCourseError(dynamic error) {
    if (error.toString().contains('course-not-found')) {
      return 'The course could not be found.';
    }

    if (error.toString().contains('duplicate-course')) {
      return 'A course with this name already exists.';
    }

    return handleError(error);
  }
}

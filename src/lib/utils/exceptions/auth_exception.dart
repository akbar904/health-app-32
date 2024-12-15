class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, [this.code]);

  @override
  String toString() =>
      'AuthException: $message${code != null ? ' (Code: $code)' : ''}';
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException() : super('Email is already in use');
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super('Invalid email or password');
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super('Password is too weak');
}

class InvalidEmailException extends AuthException {
  InvalidEmailException() : super('Invalid email format');
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('User not found');
}

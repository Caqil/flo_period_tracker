// lib/core/error/exceptions.dart

class AppException implements Exception {
  final String message;

  const AppException({required this.message});

  @override
  String toString() => message;
}

class DatabaseException extends AppException {
  const DatabaseException({required super.message});
}

class NetworkException extends AppException {
  const NetworkException({required super.message});
}

class ValidationException extends AppException {
  const ValidationException({required super.message});
}

class AuthException extends AppException {
  const AuthException({required super.message});
}

class CacheException extends AppException {
  const CacheException({required super.message});
}

class ServerException extends AppException {
  const ServerException({required super.message});
}

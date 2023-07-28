class ServerException implements Exception {}

class SocketException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

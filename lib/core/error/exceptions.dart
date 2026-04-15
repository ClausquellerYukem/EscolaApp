class ServerException implements Exception {
  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  ServerException({required this.message, this.code, this.details});
}

class CacheException implements Exception {}

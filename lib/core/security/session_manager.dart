import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SessionManager {
  final FlutterSecureStorage secureStorage;

  SessionManager(this.secureStorage);

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await secureStorage.write(key: 'access_token', value: accessToken);
    await secureStorage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'refresh_token');
  }

  Future<void> clearTokens() async {
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');
  }
}

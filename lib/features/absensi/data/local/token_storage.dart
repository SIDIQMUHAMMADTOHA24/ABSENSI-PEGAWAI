import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _s = FlutterSecureStorage();

  Future<void> saveRefreshToken(String token) {
    return _s.write(key: 'refresh_token', value: token);
  }

  Future<String?> readRefreshToken() {
    return _s.read(key: 'refresh_token');
  }

  Future<void> deleteRefreshToken() {
    return _s.delete(key: 'refresh_token');
  }
}

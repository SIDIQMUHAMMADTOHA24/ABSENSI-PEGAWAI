abstract class SessionRepository {
  Future<String?> readRefreshToken();
  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();
}

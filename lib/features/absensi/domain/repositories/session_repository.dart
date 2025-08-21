abstract class SessionRepository {
  Future<bool> hasRefreshToken();
  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();
}

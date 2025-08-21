import 'package:absensi_pegawai/features/absensi/data/local/token_storage.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final TokenStorage tokenStorage;

  SessionRepositoryImpl(this.tokenStorage);
  @override
  Future<void> deleteRefreshToken() {
    return tokenStorage.clearRefreshToken();
  }

  @override
  Future<bool> hasRefreshToken() async {
    final token = await tokenStorage.readRefreshToken();
    return (token ?? '').isNotEmpty;
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return tokenStorage.saveRefreshToken(token);
  }
}

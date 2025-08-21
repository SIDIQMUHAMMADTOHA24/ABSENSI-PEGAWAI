import 'package:absensi_pegawai/features/absensi/data/local/token_storage.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final TokenStorage tokenStorage;

  SessionRepositoryImpl(this.tokenStorage);

  @override
  Future<void> deleteRefreshToken() {
    return tokenStorage.deleteRefreshToken();
  }

  @override
  Future<bool> hasRefreshToken() async {
    String? result = await tokenStorage.readRefreshToken();
    return (result ?? '').isNotEmpty;
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return tokenStorage.saveRefreshToken(token);
  }
}

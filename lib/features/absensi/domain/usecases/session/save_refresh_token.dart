import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class SaveRefreshToken {
  final SessionRepository repository;

  SaveRefreshToken(this.repository);

  Future<void> call(String token) => repository.saveRefreshToken(token);
}

import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class SaveToken {
  final SessionRepository sessionRepository;

  SaveToken(this.sessionRepository);
  Future<void> call(String token) => sessionRepository.saveRefreshToken(token);
}

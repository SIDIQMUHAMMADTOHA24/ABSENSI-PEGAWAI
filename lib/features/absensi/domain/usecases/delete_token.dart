import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class DeleteToken {
  final SessionRepository sessionRepository;

  DeleteToken(this.sessionRepository);
  Future<void> call() => sessionRepository.deleteRefreshToken();
}

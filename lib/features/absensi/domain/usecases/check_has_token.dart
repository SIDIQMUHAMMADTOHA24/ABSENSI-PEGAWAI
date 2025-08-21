import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class CheckHasToken {
  final SessionRepository sessionRepository;

  CheckHasToken(this.sessionRepository);
  Future<bool> call() => sessionRepository.hasRefreshToken();
}

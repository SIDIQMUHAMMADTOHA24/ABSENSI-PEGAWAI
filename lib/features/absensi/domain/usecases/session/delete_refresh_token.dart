import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class DeleteRefreshToken {
  final SessionRepository repository;

  DeleteRefreshToken(this.repository);

  Future<void> call() => repository.deleteRefreshToken();
}

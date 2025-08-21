import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class HasRefreshToken {
  final SessionRepository repository;

  HasRefreshToken(this.repository);
  Future<bool> call() => repository.hasRefreshToken();
}

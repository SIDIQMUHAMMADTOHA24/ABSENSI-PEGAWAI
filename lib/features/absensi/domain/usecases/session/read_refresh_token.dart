import 'package:absensi_pegawai/features/absensi/domain/repositories/session_repository.dart';

class ReadRefreshToken {
  final SessionRepository repository;

  ReadRefreshToken(this.repository);
  Future<String?> call() => repository.readRefreshToken();
}

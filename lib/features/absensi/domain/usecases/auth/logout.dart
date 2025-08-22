import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<void> call(String refreshToken) => repository.logout(refreshToken);
}

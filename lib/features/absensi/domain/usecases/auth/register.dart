import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository authRepository;

  Register(this.authRepository);

  Future<void> call({
    required String username,
    required String password,
    required String jabatan,
  }) => authRepository.register(username, password, jabatan);
}

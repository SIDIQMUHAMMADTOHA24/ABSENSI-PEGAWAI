import 'package:absensi_pegawai/core/usecase.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

class Register implements UseCase<void, RegisterParams> {
  final AuthRepository authRepository;

  Register({required this.authRepository});

  @override
  Future<void> call(RegisterParams params) {
    return authRepository.register(
      params.username,
      params.password,
      params.jabatan,
    );
  }
}

class RegisterParams {
  final String username, password, jabatan;

  RegisterParams({
    required this.username,
    required this.password,
    required this.jabatan,
  });
}

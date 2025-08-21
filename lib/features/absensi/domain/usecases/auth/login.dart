import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

import '../../entities/auth_result.dart';

class Login {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  Future<AuthResult> call({
    required String username,
    required String password,
  }) => authRepository.login(username, password);
}

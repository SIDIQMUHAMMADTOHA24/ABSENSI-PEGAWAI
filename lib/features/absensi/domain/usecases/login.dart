import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

import '../../../../core/usecase.dart';
import '../entities/auth_result.dart';

class Login implements UseCase<AuthResult, LoginParams> {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  @override
  Future<AuthResult> call(LoginParams params) {
    return authRepository.login(params.username, params.password);
  }
}

class LoginParams {
  final String username, password;

  LoginParams({required this.username, required this.password});
}

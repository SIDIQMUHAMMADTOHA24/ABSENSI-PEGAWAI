import 'package:absensi_pegawai/features/absensi/domain/entities/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult> login(String username, String password);
  Future<void> register(String username, String password, String jabatan);
}

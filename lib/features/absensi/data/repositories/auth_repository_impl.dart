import 'package:absensi_pegawai/features/absensi/data/datasources/auth_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/auth_result.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<AuthResult> login(String username, String password) {
    return authRemoteDataSource.login(username: username, password: password);
  }

  @override
  Future<void> register(String username, String password, String jabatan) {
    return authRemoteDataSource.register(
      username: username,
      password: password,
      jabatan: jabatan,
    );
  }
}

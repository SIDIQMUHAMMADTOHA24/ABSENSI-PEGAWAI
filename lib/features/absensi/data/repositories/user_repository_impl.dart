import 'package:absensi_pegawai/features/absensi/data/datasources/user_remote_data_source.dart';

import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);
  @override
  Future<User> getUser() {
    return userRemoteDataSource.getUser();
  }
}

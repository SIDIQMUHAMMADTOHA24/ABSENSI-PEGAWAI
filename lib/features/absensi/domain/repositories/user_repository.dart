import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
}

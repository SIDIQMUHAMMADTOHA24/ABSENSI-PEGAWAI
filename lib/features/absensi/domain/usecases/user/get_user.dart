import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);
  Future<User> call() => repository.getUser();
}

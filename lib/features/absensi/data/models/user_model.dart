import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.jabatan,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
    id: j['id'] as String,
    username: j['username'] as String,
    jabatan: j['jabatan'] as String,
  );
}

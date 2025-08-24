import 'package:absensi_pegawai/features/absensi/data/models/user_model.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/auth_result.dart';

class AuthResultModel extends AuthResult {
  const AuthResultModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresAt,
    required super.user,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> j) => AuthResultModel(
    accessToken: j['access_token'] as String,
    refreshToken: j['refresh_token'] as String,
    expiresAt: DateTime.parse(j['expires_at'] as String),
    user: UserModel.fromJson(j['user'] as Map<String, dynamic>),
  );
}

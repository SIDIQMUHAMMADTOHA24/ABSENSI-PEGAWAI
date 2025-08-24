import 'package:absensi_pegawai/features/absensi/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class AuthResult extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final User user;

  const AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.user,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresAt, user];
}

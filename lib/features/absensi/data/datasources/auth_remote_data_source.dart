import 'package:absensi_pegawai/features/absensi/data/models/auth_result_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthResultModel> login({
    required String username,
    required String password,
  }) async {
    final res = await dio.post(
      '/login',
      data: {'username': username, 'password': password},
    );
    if (res.statusCode != 200) throw Exception('Login Error');
    return AuthResultModel.fromJson(Map.from(res.data as Map));
  }

  Future<void> register({
    required String username,
    required String password,
    required String jabatan,
  }) async {
    final res = await dio.post(
      '/register',
      data: {'username': username, 'password': password, 'jabatan': jabatan},
    );
    if (res.statusCode != 201) throw Exception('Register Failed');
  }

  Future<void> logout(String refreshToken) async {
    final res = await dio.post(
      '/logout',
      data: {"refresh_token": refreshToken},
    );

    if (res.statusCode != 204) throw Exception('Register Failed');
  }

  Future<AuthResultModel> refresh(String refreshToken) async {
    final res = await dio.post(
      '/refresh',
      data: {'refresh_token': refreshToken},
    );
    if (res.statusCode != 200) throw Exception('Refresh Token Failed');
    return AuthResultModel.fromJson(Map.from(res.data as Map));
  }
}

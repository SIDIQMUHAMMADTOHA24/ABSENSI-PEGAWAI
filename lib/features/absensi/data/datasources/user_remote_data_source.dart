import 'package:absensi_pegawai/features/absensi/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<UserModel> getUser() async {
    final res = await dio.get('/get-user');
    if (res.statusCode != 200) throw Exception('get user failed');
    return UserModel.fromJson(Map.from(res.data as Map));
  }
}

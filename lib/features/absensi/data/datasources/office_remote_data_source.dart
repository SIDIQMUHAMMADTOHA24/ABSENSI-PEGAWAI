import 'package:dio/dio.dart';

import '../models/office_config_model.dart';

class OfficeRemoteDataSource {
  final Dio dio;

  OfficeRemoteDataSource(this.dio);

  Future<OfficeConfigModel> fetch() async {
    final result = await dio.get('/config/office');
    if (result.statusCode != 200) throw Exception('fetch office failed');
    return OfficeConfigModel.fromJson(Map.from(result.data as Map));
  }
}

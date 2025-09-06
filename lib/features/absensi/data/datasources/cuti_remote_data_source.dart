import 'package:absensi_pegawai/features/absensi/data/models/item_model.dart';
import 'package:absensi_pegawai/features/absensi/data/models/quota_model.dart';
import 'package:dio/dio.dart';

class CutiRemoteDataSource {
  final Dio dio;

  CutiRemoteDataSource(this.dio);

  Future<QuotaModel> getQuotaCuti() async {
    final res = await dio.get('/leave/quota');
    if (res.statusCode != 200) throw Exception('Cannot get Quota Cuti');
    return QuotaModel.fromJson(Map.from(res.data as Map));
  }

  Future<List<ItemModel>> getListQuotaCuti() async {
    final res = await dio.get('/leave/cuti/list');
    if (res.statusCode != 200) throw Exception('Cannot get List Quota Cuti');

    final data = Map<String, dynamic>.from(res.data as Map);

    final item = (data['items'] as List)
        .map((e) => ItemModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return item;
  }
}

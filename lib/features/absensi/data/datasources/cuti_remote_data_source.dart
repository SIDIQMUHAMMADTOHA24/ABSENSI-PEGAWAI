import 'package:absensi_pegawai/features/absensi/data/models/history_cuti_model.dart';
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

  Future<List<HistoryCutiModel>> getHistoryCuti() async {
    final res = await dio.get('/leave/cuti/list');
    try {
      if (res.statusCode != 200) throw Exception('Cannot get List Quota Cuti');

      final data = Map<String, dynamic>.from(res.data as Map);

      final item = (data['items'] as List)
          .map((e) => HistoryCutiModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return item;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addCuti({
    required String reason,
    required String startDate,
    required String endDate,
  }) async {
    final res = await dio.post(
      '/leave/cuti/request',
      data: {"reason": reason, "start_date": startDate, "end_date": endDate},
    );
    if (res.statusCode != 201) return false;
    return true;
  }
}

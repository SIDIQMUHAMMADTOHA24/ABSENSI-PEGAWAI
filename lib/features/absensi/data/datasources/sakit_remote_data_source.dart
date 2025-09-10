import 'package:dio/dio.dart';

import '../models/history_sakit_model.dart';

class SakitRemoteDataSource {
  final Dio dio;

  SakitRemoteDataSource(this.dio);

  Future<List<HistorySakitModel>> getHistorySakit() async {
    final res = await dio.get('/leave/sakit/list');
    print('res = ${res.data}');
    try {
      if (res.statusCode != 200) throw Exception('Cannot get List Quota Sakit');

      final data = Map<String, dynamic>.from(res.data as Map);

      final item = (data['items'] as List)
          .map((e) => HistorySakitModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      item.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      print('item sakit $item');

      return item;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addSakit({
    required String reason,
    required String image,
    required String startDate,
    required String endDate,
  }) async {
    final res = await dio.post(
      '/leave/sakit/request',
      data: {
        "reason": reason,
        "doctor_note_base64": image,
        "start_date": startDate,
        "end_date": endDate,
      },
    );
    if (res.statusCode != 201) return false;
    return true;
  }
}

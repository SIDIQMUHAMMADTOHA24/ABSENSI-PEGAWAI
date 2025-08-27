import 'package:absensi_pegawai/features/absensi/data/models/attendance_model.dart';
import 'package:dio/dio.dart';

import '../models/attendance_day_detail_model.dart';
import '../models/attendance_marks_model.dart';

class AttendanceRemoteDataSource {
  final Dio dio;

  AttendanceRemoteDataSource(this.dio);

  Future<AttendanceStatusModel> getStatus(double? lat, double? long) async {
    final res = await dio.post(
      '/attendance/status',
      data: {if (lat != null) 'lat': lat, if (long != null) 'lng': long},
    );
    if (res.statusCode != 200) throw Exception('status failed');
    return AttendanceStatusModel.fromJson(Map.from(res.data));
  }

  Future<void> checkIn({
    required double lat,
    required double long,
    required String selfieBase64,
  }) async {
    final res = await dio.post(
      '/attendance/check-in',
      data: {'lat': lat, 'lng': long, 'selfie_base64': selfieBase64},
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('check-in failed');
    }
  }

  Future<void> checkOut({
    required double lat,
    required double long,
    required String selfieBase64,
  }) async {
    final res = await dio.post(
      '/attendance/check-out',
      data: {'lat': lat, 'lng': long, 'selfie_base64': selfieBase64},
    );
    if (res.statusCode != 200) {
      throw Exception('check-out failed');
    }
  }

  Future<AttendanceMarksModel> getMarks({
    String? month,
    String tz = 'Asia/Jakarta',
  }) async {
    final qp = <String, dynamic>{'tz': tz, if (month != null) 'month': month};
    final res = await dio.get('/attendance/marks', queryParameters: qp);
    if (res.statusCode != 200) throw Exception('get marks failed');
    return AttendanceMarksModel.fromJson(Map<String, dynamic>.from(res.data));
  }

  // --- BARU: detail per hari ---
  Future<AttendanceDayDetailModel> getDay({
    required String date,
    String tz = 'Asia/Jakarta',
  }) async {
    final res = await dio.get(
      '/attendance/day',
      queryParameters: {'date': date, 'tz': tz},
    );
    if (res.statusCode != 200) throw Exception('get day failed');
    return AttendanceDayDetailModel.fromJson(
      Map<String, dynamic>.from(res.data),
    );
  }
}

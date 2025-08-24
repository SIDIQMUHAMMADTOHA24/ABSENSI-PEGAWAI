import 'package:absensi_pegawai/features/absensi/data/models/attendance_model.dart';
import 'package:dio/dio.dart';

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

  Future<void> checkIn({required double lat, required double lng}) async {
    final res = await dio.post(
      '/attendance/check-in',
      data: {'lat': lat, 'lng': lng},
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('check-in failed');
    }
  }

  Future<void> checkOut({required double lat, required double lng}) async {
    final res = await dio.post(
      '/attendance/check-out',
      data: {'lat': lat, 'lng': lng},
    );
    if (res.statusCode != 200) {
      throw Exception('check-out failed');
    }
  }
}

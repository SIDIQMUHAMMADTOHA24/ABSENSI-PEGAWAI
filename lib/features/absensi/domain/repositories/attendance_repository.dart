import 'package:absensi_pegawai/features/absensi/domain/entities/attendance.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/attendance_day_detail.dart';

import '../entities/attendance_marks.dart';

abstract class AttendanceRepository {
  Future<AttendanceStatus> getStatus({double? lat, double? long});
  Future<void> checkIn({
    required double lat,
    required double long,
    required String selfieBase64,
  });
  Future<void> checkOut({
    required double lat,
    required double long,
    required String selfieBase64,
  });
  Future<AttendanceMarks> getMarks({String? month, String tz = 'Asia/Jakarta'});
  Future<AttendanceDayDetail> getDay({
    required String date,
    String tz = 'Asia/Jakarta',
  });
}

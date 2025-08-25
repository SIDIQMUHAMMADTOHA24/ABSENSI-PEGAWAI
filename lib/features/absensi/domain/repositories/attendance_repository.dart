import 'package:absensi_pegawai/features/absensi/domain/entities/attendance.dart';

abstract class AttendanceRepository {
  Future<AttendanceStatus> getStatus({double? lat, double? long});
  Future<void> checkIn({required double lat, required double long});
  Future<void> checkOut({required double lat, required double long});
}

import 'package:absensi_pegawai/features/absensi/data/datasources/attendance_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/attendance.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/attendance_repository.dart';

import '../../domain/entities/attendance_day_detail.dart';
import '../../domain/entities/attendance_marks.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource repository;

  AttendanceRepositoryImpl(this.repository);

  @override
  Future<void> checkIn({required double lat, required double long}) {
    return repository.checkIn(lat: lat, long: long);
  }

  @override
  Future<void> checkOut({required double lat, required double long}) {
    return repository.checkOut(lat: lat, long: long);
  }

  @override
  Future<AttendanceStatus> getStatus({double? lat, double? long}) {
    return repository.getStatus(lat, long);
  }

  @override
  Future<AttendanceMarks> getMarks({
    String? month,
    String tz = 'Asia/Jakarta',
  }) async {
    final m = await repository.getMarks(month: month, tz: tz);
    return m; // sudah entity-compatible (model extends entity)
  }

  @override
  Future<AttendanceDayDetail> getDay({
    required String date,
    String tz = 'Asia/Jakarta',
  }) async {
    final d = await repository.getDay(date: date, tz: tz);
    return d; // model extends entity
  }
}

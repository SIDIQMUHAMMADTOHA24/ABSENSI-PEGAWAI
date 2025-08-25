import 'package:absensi_pegawai/features/absensi/data/datasources/attendance_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/attendance.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/attendance_repository.dart';

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
}

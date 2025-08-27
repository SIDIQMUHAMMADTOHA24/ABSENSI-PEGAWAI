import '../../entities/attendance.dart';
import '../../repositories/attendance_repository.dart';

class GetAttendanceStatus {
  final AttendanceRepository repo;
  GetAttendanceStatus(this.repo);

  Future<AttendanceStatus> call({double? lat, double? long}) =>
      repo.getStatus(lat: lat, long: long);
}

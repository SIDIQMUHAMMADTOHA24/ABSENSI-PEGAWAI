import '../../repositories/attendance_repository.dart';

class CheckIn {
  final AttendanceRepository repo;
  CheckIn(this.repo);
  Future<void> call({required double lat, required double long}) =>
      repo.checkIn(lat: lat, long: long);
}

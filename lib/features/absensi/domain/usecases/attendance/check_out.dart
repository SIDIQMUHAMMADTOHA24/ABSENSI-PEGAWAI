import '../../repositories/attendance_repository.dart';

class CheckOut {
  final AttendanceRepository repo;
  CheckOut(this.repo);
  Future<void> call({required double lat, required double long}) =>
      repo.checkOut(lat: lat, long: long);
}

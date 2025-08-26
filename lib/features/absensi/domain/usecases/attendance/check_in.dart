import '../../repositories/attendance_repository.dart';

class CheckIn {
  final AttendanceRepository repo;
  CheckIn(this.repo);
  Future<void> call({
    required double lat,
    required double long,
    required String selfieBase64,
  }) => repo.checkIn(lat: lat, long: long, selfieBase64: selfieBase64);
}

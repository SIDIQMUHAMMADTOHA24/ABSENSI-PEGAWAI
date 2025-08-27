import '../../repositories/attendance_repository.dart';

class CheckOut {
  final AttendanceRepository repo;
  CheckOut(this.repo);
  Future<void> call({
    required double lat,
    required double long,
    required String selfieBase64,
  }) => repo.checkOut(lat: lat, long: long, selfieBase64: selfieBase64);
}

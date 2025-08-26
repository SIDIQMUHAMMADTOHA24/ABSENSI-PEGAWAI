import '../../entities/attendance_day_detail.dart';
import '../../repositories/attendance_repository.dart';

class GetAttendanceDay {
  final AttendanceRepository repo;
  GetAttendanceDay(this.repo);

  /// [date] format "YYYY-MM-DD"
  Future<AttendanceDayDetail> call({
    required String date,
    String tz = 'Asia/Jakarta',
  }) {
    return repo.getDay(date: date, tz: tz);
  }
}

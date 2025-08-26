import '../../entities/attendance_marks.dart';
import '../../repositories/attendance_repository.dart';

class GetAttendanceMarks {
  final AttendanceRepository repo;
  GetAttendanceMarks(this.repo);

  /// [month] format "YYYY-MM" (opsional, default bulan ini di server).
  /// [tz] default "Asia/Jakarta"
  Future<AttendanceMarks> call({String? month, String tz = 'Asia/Jakarta'}) {
    return repo.getMarks(month: month, tz: tz);
  }
}

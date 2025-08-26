import '../../domain/entities/attendance_marks.dart';

class AttendanceMarksModel extends AttendanceMarks {
  const AttendanceMarksModel({
    required super.month,
    required super.daysPresent,
  });

  factory AttendanceMarksModel.fromJson(Map<String, dynamic> j) {
    final days = (j['days_present'] as List? ?? [])
        .map((e) => DateTime.parse(e as String))
        .toList();
    return AttendanceMarksModel(month: j['month'] as String, daysPresent: days);
  }
}

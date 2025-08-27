import 'package:equatable/equatable.dart';

class AttendanceMarks extends Equatable {
  final String month; // "YYYY-MM"
  final List<DateTime> daysPresent; // tanggal UTC (tanpa jam)

  const AttendanceMarks({required this.month, required this.daysPresent});

  @override
  List<Object?> get props => [month, daysPresent];
}

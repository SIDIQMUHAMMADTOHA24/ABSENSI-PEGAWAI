import 'package:equatable/equatable.dart';

enum NextAction { checkIn, checkOut, none }

class DayStatus extends Equatable {
  final DateTime date;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final int workedSeconds;
  const DayStatus({
    required this.date,
    required this.checkInAt,
    required this.checkOutAt,
    required this.workedSeconds,
  });
  @override
  List<Object?> get props => [date, checkInAt, checkOutAt, workedSeconds];
}

class AttendanceStatus extends Equatable {
  final bool insideRadius;
  final double distanceM;
  final DayStatus? today;
  final NextAction nextAction;
  const AttendanceStatus({
    required this.insideRadius,
    required this.distanceM,
    required this.today,
    required this.nextAction,
  });
  @override
  List<Object?> get props => [insideRadius, distanceM, today, nextAction];
}

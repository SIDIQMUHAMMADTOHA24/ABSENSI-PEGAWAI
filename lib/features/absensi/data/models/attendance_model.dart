import '../../domain/entities/attendance.dart';

NextAction _toNext(String? s) {
  switch ((s ?? '').toLowerCase()) {
    case 'check_in':
      return NextAction.checkIn;
    case 'check_out':
      return NextAction.checkOut;
    default:
      return NextAction.none;
  }
}

class DayStatusModel extends DayStatus {
  const DayStatusModel({
    required super.date,
    required super.checkInAt,
    required super.checkOutAt,
    required super.workedSeconds,
  });

  factory DayStatusModel.fromJson(Map<String, dynamic> j) => DayStatusModel(
    date: DateTime.parse(j['date'] as String),
    checkInAt: j['check_in_at'] != null
        ? DateTime.parse(j['check_in_at'])
        : null,
    checkOutAt: j['check_out_at'] != null
        ? DateTime.parse(j['check_out_at'])
        : null,
    workedSeconds: (j['worked_seconds'] as num).toInt(),
  );
}

class AttendanceStatusModel extends AttendanceStatus {
  const AttendanceStatusModel({
    required super.insideRadius,
    required super.distanceM,
    required super.today,
    required super.nextAction,
  });

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> j) =>
      AttendanceStatusModel(
        insideRadius: j['inside_radius'] as bool,
        distanceM: (j['distance_m'] as num).toDouble(),
        today: j['today'] != null ? DayStatusModel.fromJson(j['today']) : null,
        nextAction: _toNext(j['next_action'] as String?),
      );
}

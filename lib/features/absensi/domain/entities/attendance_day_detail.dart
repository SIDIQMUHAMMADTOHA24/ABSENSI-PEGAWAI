import 'package:equatable/equatable.dart';

enum AttendanceEventType { checkIn, checkOut }

class AttendanceEvent extends Equatable {
  final AttendanceEventType type;
  final DateTime at; // UTC
  final double? lat, lng;
  final double? distanceM;

  const AttendanceEvent({
    required this.type,
    required this.at,
    this.lat,
    this.lng,
    this.distanceM,
  });

  @override
  List<Object?> get props => [type, at, lat, lng, distanceM];
}

class AttendanceDayDetail extends Equatable {
  final DateTime date; // hari yg diminta (local->UTC anchor)
  final List<AttendanceEvent> events;
  final int workedSeconds;

  const AttendanceDayDetail({
    required this.date,
    required this.events,
    required this.workedSeconds,
  });

  @override
  List<Object?> get props => [date, events, workedSeconds];
}

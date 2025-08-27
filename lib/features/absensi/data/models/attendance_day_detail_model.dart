import '../../domain/entities/attendance_day_detail.dart';

AttendanceEventType _mapType(String s) {
  switch (s.toLowerCase()) {
    case 'check_in':
      return AttendanceEventType.checkIn;
    case 'check_out':
      return AttendanceEventType.checkOut;
    default:
      return AttendanceEventType.checkIn;
  }
}

class AttendanceDayDetailModel extends AttendanceDayDetail {
  const AttendanceDayDetailModel({
    required super.date,
    required super.events,
    required super.workedSeconds,
  });

  factory AttendanceDayDetailModel.fromJson(Map<String, dynamic> j) {
    final eventsJson = (j['events'] as List? ?? []);
    final events = eventsJson.map((e) {
      final m = e as Map<String, dynamic>;
      return AttendanceEvent(
        type: _mapType(m['type'] as String),
        at: DateTime.parse(m['at'] as String), // server kirim UTC RFC3339
        lat: (m['lat'] as num?)?.toDouble(),
        lng: (m['lng'] as num?)?.toDouble(),
        distanceM: (m['distance_m'] as num?)?.toDouble(),
      );
    }).toList();

    return AttendanceDayDetailModel(
      date: DateTime.parse(j['date'] as String),
      events: events,
      workedSeconds: (j['worked_seconds'] as num).toInt(),
    );
  }
}

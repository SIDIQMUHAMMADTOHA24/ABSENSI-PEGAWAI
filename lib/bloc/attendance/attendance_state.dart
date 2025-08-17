part of 'attendance_bloc.dart';

class AttendanceState {
  final bool loading;
  final double? lat;
  final double? lon;
  final double? distanceM;
  final bool inside;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final String? toast; // one-shot message

  const AttendanceState({
    this.loading = true,
    this.lat,
    this.lon,
    this.distanceM,
    this.inside = false,
    this.checkInAt,
    this.checkOutAt,
    this.toast,
  });

  AttendanceState copyWith({
    bool? loading,
    double? lat,
    double? lon,
    double? distanceM,
    bool? inside,
    DateTime? checkInAt,
    DateTime? checkOutAt,
    String? toast,
  }) {
    return AttendanceState(
      loading: loading ?? this.loading,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      distanceM: distanceM ?? this.distanceM,
      inside: inside ?? this.inside,
      checkInAt: checkInAt ?? this.checkInAt,
      checkOutAt: checkOutAt ?? this.checkOutAt,
      toast: toast,
    );
  }

  static const initial = AttendanceState();
}

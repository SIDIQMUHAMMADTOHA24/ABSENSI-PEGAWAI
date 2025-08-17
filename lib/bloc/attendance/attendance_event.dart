part of 'attendance_bloc.dart';

sealed class AttendanceEvent {}

class AppStarted extends AttendanceEvent {} // load prefs + izin + stream

class PositionUpdated extends AttendanceEvent {
  final Position pos;
  PositionUpdated(this.pos);
}

class CheckInPressed extends AttendanceEvent {}

class CheckOutPressed extends AttendanceEvent {}

class ResetPressed extends AttendanceEvent {}

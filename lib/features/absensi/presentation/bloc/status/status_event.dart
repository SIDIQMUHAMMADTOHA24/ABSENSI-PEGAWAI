part of 'status_bloc.dart';

sealed class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object> get props => [];
}

class Init extends StatusEvent {
  const Init();
}

class PositionChanged extends StatusEvent {
  final GeoPos pos;
  const PositionChanged(this.pos);
  @override
  List<Object> get props => [pos];
}

class RefreshServerStatus extends StatusEvent {
  const RefreshServerStatus();
}

class RequestCheckIn extends StatusEvent {
  final String selfieBase64;
  const RequestCheckIn(this.selfieBase64);
  @override
  List<Object> get props => [selfieBase64];
}

class RequestCheckOut extends StatusEvent {
  final String selfieBase64;
  const RequestCheckOut(this.selfieBase64);
  @override
  List<Object> get props => [selfieBase64];
}

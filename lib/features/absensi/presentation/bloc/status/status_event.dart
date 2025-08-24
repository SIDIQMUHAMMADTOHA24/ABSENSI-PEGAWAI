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

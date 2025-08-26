part of 'calender_bloc.dart';

sealed class CalenderEvent extends Equatable {
  const CalenderEvent();

  @override
  List<Object> get props => [];
}

class LoadMonth extends CalenderEvent {
  final DateTime monthAnchor;
  final String tz;

  const LoadMonth({required this.monthAnchor, this.tz = 'Asia/Jakarta'});

  @override
  List<Object> get props => [monthAnchor, tz];
}

class LoadDay extends CalenderEvent {
  final DateTime date;
  final String tz;

  const LoadDay({required this.date, this.tz = 'Asia/Jakarta'});

  @override
  List<Object> get props => [date, tz];
}

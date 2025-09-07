part of 'cuti_bloc.dart';

sealed class CutiEvent extends Equatable {
  const CutiEvent();

  @override
  List<Object> get props => [];
}

class GetQuotaCuti extends CutiEvent {
  GetQuotaCuti();
}

class GetHistoryCuti extends CutiEvent {
  GetHistoryCuti();
}

class AddCutiEvent extends CutiEvent {
  final String reason;
  final String startDate;
  final String endDate;

  AddCutiEvent({
    required this.reason,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [reason, startDate, endDate];
}

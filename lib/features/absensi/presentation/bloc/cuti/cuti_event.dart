part of 'cuti_bloc.dart';

sealed class CutiEvent extends Equatable {
  const CutiEvent();

  @override
  List<Object> get props => [];
}

class GetQuotaCuti extends CutiEvent {
  GetQuotaCuti();
}

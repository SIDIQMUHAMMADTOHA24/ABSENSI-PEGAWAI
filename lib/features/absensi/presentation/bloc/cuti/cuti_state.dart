// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cuti_bloc.dart';

class CutiState extends Equatable {
  final Quota? quotaCuti;
  final String? error;
  final List<HistoryCuti>? listHistoryCuti;
  const CutiState({this.quotaCuti, this.error, this.listHistoryCuti});

  CutiState copyWith({
    Quota? quotaCuti,
    String? error,
    List<HistoryCuti>? listHistoryCuti,
  }) {
    return CutiState(
      quotaCuti: quotaCuti ?? this.quotaCuti,
      error: error ?? this.error,
      listHistoryCuti: listHistoryCuti ?? this.listHistoryCuti,
    );
  }

  @override
  List<Object?> get props => [quotaCuti, error, listHistoryCuti];
}

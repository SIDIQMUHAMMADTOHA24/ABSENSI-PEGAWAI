// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cuti_bloc.dart';

class CutiState extends Equatable {
  final Quota? quotaCuti;
  final String? error;
  final List<HistoryCuti>? listHistoryCuti;
  final bool loadingAddCuti;
  final String? addSuccess;
  final String? addFailed;
  const CutiState({
    this.quotaCuti,
    this.error,
    this.listHistoryCuti,
    this.addSuccess,
    this.addFailed,
    this.loadingAddCuti = false,
  });

  CutiState copyWith({
    Quota? quotaCuti,
    String? error,
    String? addSuccess,
    String? addFailed,
    List<HistoryCuti>? listHistoryCuti,
    bool? loadingAddCuti = false,
  }) {
    return CutiState(
      quotaCuti: quotaCuti ?? this.quotaCuti,
      error: error ?? this.error,
      listHistoryCuti: listHistoryCuti ?? this.listHistoryCuti,
      addSuccess: addSuccess ?? this.addSuccess,
      addFailed: addFailed ?? this.addFailed,
      loadingAddCuti: loadingAddCuti ?? this.loadingAddCuti,
    );
  }

  @override
  List<Object?> get props => [
    quotaCuti,
    error,
    listHistoryCuti,
    addSuccess,
    addFailed,
    loadingAddCuti,
  ];
}

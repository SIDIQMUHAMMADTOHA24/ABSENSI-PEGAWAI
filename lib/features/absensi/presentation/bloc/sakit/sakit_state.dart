// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sakit_bloc.dart';

class SakitState extends Equatable {
  const SakitState({
    this.listDataSakit,
    this.error,
    this.path,
    this.base64,
    this.loadingAddSakit = false,
    this.addSuccess,
    this.addFailed,
  });
  final List<HistorySakit>? listDataSakit;
  final String? error;
  final String? path;
  final String? base64;
  final bool loadingAddSakit;
  final String? addSuccess;
  final String? addFailed;

  @override
  List<Object?> get props => [
    listDataSakit,
    error,
    path,
    base64,
    loadingAddSakit,
    addSuccess,
    addFailed,
  ];

  SakitState copyWith({
    List<HistorySakit>? listDataSakit,
    String? error,
    ValueGetter<String?>? path,
    ValueGetter<String?>? base64,
    bool? loadingAddSakit = false,
    ValueGetter<String?>? addSuccess,
    ValueGetter<String?>? addFailed,
  }) {
    return SakitState(
      listDataSakit: listDataSakit ?? this.listDataSakit,
      error: error ?? this.error,
      path: path != null ? path() : this.path,
      base64: base64 != null ? base64() : this.base64,
      loadingAddSakit: loadingAddSakit ?? this.loadingAddSakit,
      addSuccess: addSuccess != null ? addSuccess() : this.addSuccess,
      addFailed: addFailed != null ? addFailed() : this.addFailed,
    );
  }
}

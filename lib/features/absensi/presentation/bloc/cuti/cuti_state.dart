// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cuti_bloc.dart';

class CutiState extends Equatable {
  final Quota? quotaCuti;
  final String? error;
  const CutiState({this.quotaCuti, this.error});

  CutiState copyWith({Quota? quotaCuti, String? error}) {
    return CutiState(
      quotaCuti: quotaCuti ?? this.quotaCuti,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [quotaCuti, error];
}

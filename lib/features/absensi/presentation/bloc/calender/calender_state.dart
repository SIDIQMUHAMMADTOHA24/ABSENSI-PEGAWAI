part of 'calender_bloc.dart';

class CalenderState extends Equatable {
  final bool loading;
  final bool detailLoading;
  final String? error;
  final AttendanceMarks? marks;
  final AttendanceDayDetail? dayDetail;

  const CalenderState({
    this.loading = false,
    this.detailLoading = false,
    this.error,
    this.marks,
    this.dayDetail,
  });

  CalenderState copyWith({
    bool? loading,
    bool? detailLoading,
    String? error,
    AttendanceMarks? marks,
    AttendanceDayDetail? dayDetail,
  }) {
    return CalenderState(
      loading: loading ?? this.loading,
      detailLoading: detailLoading ?? this.detailLoading,
      error: error,
      marks: marks ?? this.marks,
      dayDetail: dayDetail ?? this.dayDetail,
    );
  }

  @override
  List<Object?> get props => [loading, detailLoading, error, marks, dayDetail];
}

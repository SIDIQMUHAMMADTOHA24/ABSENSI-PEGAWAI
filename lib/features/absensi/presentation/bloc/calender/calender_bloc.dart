import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/attendance_day_detail.dart';
import '../../../domain/entities/attendance_marks.dart';
import '../../../domain/usecases/attendance/get_attendance_day.dart';
import '../../../domain/usecases/attendance/get_attendance_marks.dart';

part 'calender_event.dart';
part 'calender_state.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final GetAttendanceMarks getMarksUC;
  final GetAttendanceDay getDayUC;

  CalenderBloc(this.getMarksUC, this.getDayUC) : super(CalenderState()) {
    on<LoadMonth>(_loadMonth);
    on<LoadDay>(_loadDay);
  }

  String _ym(DateTime d) => DateFormat('yyyy-MM').format(d);
  String _ymd(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  Future<void> _loadMonth(LoadMonth event, Emitter<CalenderState> emit) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final marks = await getMarksUC(
        month: _ym(event.monthAnchor),
        tz: event.tz,
      );
      emit(state.copyWith(loading: false, marks: marks));
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'failed to load marks'));
    }
  }

  Future<void> _loadDay(LoadDay event, Emitter<CalenderState> emit) async {
    emit(state.copyWith(detailLoading: true, error: null));
    try {
      final detail = await getDayUC(date: _ymd(event.date), tz: event.tz);
      emit(state.copyWith(detailLoading: false, dayDetail: detail));
    } catch (e) {
      emit(state.copyWith(detailLoading: false, error: 'failed to load day'));
    }
  }
}

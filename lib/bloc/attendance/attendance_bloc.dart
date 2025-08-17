import 'dart:async';
import 'package:absensi_pegawai/repository/attendance_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository repo;
  StreamSubscription<Position>? _stream;

  AttendanceBloc(this.repo) : super(AttendanceState.initial) {
    on<AppStarted>(_onStarted);
    on<PositionUpdated>(_onPositionUpdated);
    on<CheckInPressed>(_onCheckIn);
    on<CheckOutPressed>(_onCheckOut);
    on<ResetPressed>(_onReset);
  }

  Future<void> _onStarted(AppStarted e, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(loading: true));
    final (ci, co) = await repo.loadTimes();
    await repo.ensurePermission();

    // posisi awal
    final first = await repo.getCurrent();
    final d = repo.distanceToOffice(first.latitude, first.longitude);
    emit(
      state.copyWith(
        loading: false,
        lat: first.latitude,
        lon: first.longitude,
        distanceM: d,
        inside: d <= AttendanceRepository.officeRadiusM,
        checkInAt: ci,
        checkOutAt: co,
      ),
    );

    // stream berkelanjutan
    _stream?.cancel();
    _stream = repo.startPositionStream().listen((p) => add(PositionUpdated(p)));
  }

  void _onPositionUpdated(PositionUpdated e, Emitter<AttendanceState> emit) {
    final p = e.pos;
    final d = repo.distanceToOffice(p.latitude, p.longitude);
    emit(
      state.copyWith(
        lat: p.latitude,
        lon: p.longitude,
        distanceM: d,
        inside: d <= AttendanceRepository.officeRadiusM,
      ),
    );
  }

  Future<void> _onCheckIn(
    CheckInPressed e,
    Emitter<AttendanceState> emit,
  ) async {
    if (!state.inside || state.checkInAt != null) return;
    final now = DateTime.now();
    emit(
      state.copyWith(
        checkInAt: now,
        checkOutAt: null,
        toast: 'Berhasil check-in',
      ),
    );
    await repo.saveTimes(now, null);
  }

  Future<void> _onCheckOut(
    CheckOutPressed e,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.checkInAt == null || state.checkOutAt != null) return;
    final now = DateTime.now();
    emit(state.copyWith(checkOutAt: now, toast: 'Berhasil check-out'));
    await repo.saveTimes(state.checkInAt, now);
  }

  Future<void> _onReset(ResetPressed e, Emitter<AttendanceState> emit) async {
    emit(state.copyWith(checkInAt: null, checkOutAt: null, toast: 'Reset'));
    await repo.saveTimes(null, null);
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    repo.stopStream();
    return super.close();
  }
}

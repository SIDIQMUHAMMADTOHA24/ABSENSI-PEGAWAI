import 'dart:async';

import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/attendance.dart';
import '../../../domain/usecases/absensi/ensure_permission.dart';
import '../../../domain/usecases/absensi/get_current_pos.dart';
import '../../../domain/usecases/absensi/get_office_config.dart';
import '../../../domain/usecases/absensi/watch_position.dart';
import '../../../../../core/geo/geo_math.dart';
import '../../../domain/usecases/attendance/check_in.dart';
import '../../../domain/usecases/attendance/check_out.dart';
import '../../../domain/usecases/attendance/get_attendance_status.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final EnsurePermission ensurePermission;
  final GetCurrentPos getCurrentPos;
  final WatchPosition watchPosition;
  final GetOfficeConfig getOfficeConfig;
  final GetAttendanceStatus getAttendanceStatus;
  final CheckIn checkIn;
  final CheckOut checkOut;
  StreamSubscription? _sub;

  StatusBloc({
    required this.ensurePermission,
    required this.getCurrentPos,
    required this.watchPosition,
    required this.getOfficeConfig,
    required this.getAttendanceStatus,
    required this.checkIn,
    required this.checkOut,
  }) : super(StatusState()) {
    on<Init>(_init);
    on<PositionChanged>(_onPositionChanged);
    on<RefreshServerStatus>(_refreshFromServer);
    on<RequestCheckIn>(_doCheckIn);
    on<RequestCheckOut>(_doCheckOut);
  }

  Future<void> _init(Init event, Emitter<StatusState> emit) async {
    emit(state.copy(loading: true, error: null));
    try {
      final granted = await ensurePermission();
      if (!granted) {
        emit(state.copy(loading: false, error: 'Permission Denied'));
        return;
      }

      final office = await getOfficeConfig();
      final position = await getCurrentPos();

      final haversineM = haversineMeters(
        lat1: position.lat,
        lon1: position.long,
        lat2: office.lat,
        lon2: office.long,
      );

      emit(
        state.copy(
          loading: false,
          officeLat: office.lat,
          officeLng: office.long,
          radiusM: office.radiusM,
          userLat: position.lat,
          userLng: position.long,
          userAccM: position.accuracyM,
          distanceM: haversineM,
          inside: haversineM <= office.radiusM,
        ),
      );

      _sub?.cancel();
      _sub = watchPosition(distanceFilterM: 5).listen((pos) {
        print('pos user = ${pos.lat} | ${pos.long}');
        if (isClosed) return;
        add(PositionChanged(pos));
      });

      add(const RefreshServerStatus());
    } catch (e) {
      emit(state.copy(loading: false, error: 'Failed to get location'));
    }
  }

  void _onPositionChanged(
    PositionChanged event,
    Emitter<StatusState> emit,
  ) async {
    final officeLat = state.officeLat;
    final officeLng = state.officeLng;
    final radiusM = state.radiusM;
    if (officeLat == null || officeLng == null || radiusM == null) return;

    final dist = haversineMeters(
      lat1: event.pos.lat,
      lon1: event.pos.long,
      lat2: officeLat,
      lon2: officeLng,
    );

    emit(
      state.copy(
        userLat: event.pos.lat,
        userLng: event.pos.long,
        userAccM: event.pos.accuracyM,
        distanceM: dist,
        inside: dist <= radiusM,
      ),
    );
  }

  Future<void> _refreshFromServer(
    RefreshServerStatus e,
    Emitter<StatusState> emit,
  ) async {
    try {
      final lat = state.userLat, long = state.userLng;
      final s = await getAttendanceStatus(lat: lat, long: long);
      print('status = $s');
      emit(
        state.copy(
          todayDate: s.today?.date,
          checkInAt: s.today?.checkInAt,
          checkOutAt: s.today?.checkOutAt,
          workedSeconds: s.today?.workedSeconds,
          nextAction: s.nextAction,
        ),
      );
    } catch (e) {
      print('error get status = $e');
      // optional: toast error
    }
  }

  Future<void> _doCheckIn(RequestCheckIn e, Emitter<StatusState> emit) async {
    final lat = state.userLat, lng = state.userLng;
    if (lat == null || lng == null) return;
    if (!(state.inside ?? false)) return;
    try {
      print('skiw');
      await checkIn(lat: lat, long: lng, selfieBase64: e.selfieBase64);
      add(const RefreshServerStatus());
    } catch (e) {
      print('error = $e');
      // optional: set error/toast
    }
  }

  Future<void> _doCheckOut(RequestCheckOut e, Emitter<StatusState> emit) async {
    final lat = state.userLat, long = state.userLng;
    if (lat == null || long == null) return;
    if (!(state.inside ?? false)) return;
    try {
      await checkOut(lat: lat, long: long, selfieBase64: e.selfieBase64);
      add(const RefreshServerStatus());
    } catch (e) {
      print('error = $e');
      // optional: set error/toast
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}

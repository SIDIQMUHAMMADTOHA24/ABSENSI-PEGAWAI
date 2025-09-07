import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/cuti/quota_cuti.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quota.dart';
import '../../../domain/usecases/cuti/add_cuti.dart';
import '../../../domain/usecases/cuti/list_hisotry_cuti.dart';

part 'cuti_event.dart';
part 'cuti_state.dart';

class CutiBloc extends Bloc<CutiEvent, CutiState> {
  final QuotaCuti quotaCuti;
  final ListHistoryCuti listHistoryItem;
  final AddCuti addCuti;

  CutiBloc({
    required this.quotaCuti,
    required this.listHistoryItem,
    required this.addCuti,
  }) : super(CutiState()) {
    on<GetQuotaCuti>(getQuotaCuti);
    on<GetHistoryCuti>(getHistoryCuti);
    on<AddCutiEvent>(addCutiEvent);
  }

  Future<void> getQuotaCuti(GetQuotaCuti event, Emitter<CutiState> emit) async {
    try {
      Quota result = await quotaCuti();
      emit(state.copyWith(quotaCuti: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> getHistoryCuti(
    GetHistoryCuti event,
    Emitter<CutiState> emit,
  ) async {
    try {
      List<HistoryCuti> result = await listHistoryItem();
      emit(state.copyWith(listHistoryCuti: result));
    } catch (e) {
      print(e);
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> addCutiEvent(AddCutiEvent event, Emitter<CutiState> emit) async {
    emit(state.copyWith(loadingAddCuti: true));
    try {
      bool res = await addCuti(
        reason: event.reason,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      if (res) {
        emit(state.copyWith(addSuccess: 'Berhasil meminta cuti'));
        emit(state.copyWith(loadingAddCuti: false));
        add(GetHistoryCuti());
      } else {
        emit(state.copyWith(addFailed: 'Gagal meminta cuti'));
        emit(state.copyWith(loadingAddCuti: false));
      }
    } catch (e) {
      emit(state.copyWith(addFailed: 'Gagal meminta cuti'));
      emit(state.copyWith(loadingAddCuti: false));
    }
  }
}

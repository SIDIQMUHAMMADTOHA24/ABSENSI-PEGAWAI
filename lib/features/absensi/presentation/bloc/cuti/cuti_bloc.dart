import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/cuti/quota_cuti.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    on<ClearMessage>(clearMessage);
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
    if (event.startDate.isNotEmpty &&
        event.endDate.isNotEmpty &&
        event.reason.isNotEmpty) {
      final inputFormat = DateFormat('dd/MM/yyyy');
      DateTime startDate = inputFormat.parse(event.startDate);

      DateTime endDate = inputFormat.parse(event.endDate);

      emit(state.copyWith(loadingAddCuti: true));
      try {
        bool res = await addCuti(
          reason: event.reason,
          startDate: DateFormat('yyyy-MM-dd').format(startDate),
          endDate: DateFormat('yyyy-MM-dd').format(endDate),
        );

        if (res) {
          emit(
            state.copyWith(
              addSuccess: 'Berhasil meminta cuti',
              loadingAddCuti: false,
            ),
          );
          add(GetHistoryCuti());
        } else {
          emit(
            state.copyWith(
              addFailed: 'Gagal meminta cuti',
              loadingAddCuti: false,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            addFailed: 'Gagal meminta cuti',
            loadingAddCuti: false,
          ),
        );
      }
    }
  }

  Future<void> clearMessage(ClearMessage event, Emitter<CutiState> emit) async {
    event.keperluanController.clear();
    event.startCutiController.clear();
    event.endCutiController.clear();
    emit(state.copyWith(addFailed: null, addSuccess: null));
  }
}

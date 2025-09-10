import 'package:absensi_pegawai/features/absensi/domain/entities/history_sakit.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/sakit/add_sakit.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/sakit/list_history_sakit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'sakit_event.dart';
part 'sakit_state.dart';

class SakitBloc extends Bloc<SakitEvent, SakitState> {
  final ListHistorySakit listHistorySakit;
  final AddSakit addSakit;
  SakitBloc({required this.listHistorySakit, required this.addSakit})
    : super(SakitState()) {
    on<GetHistorySakit>(getHistorySakit);
    on<SetPathAndBase64>(setPatchAndBase64);
    on<AddSakitEvent>(addSakitEvent);
    on<ClearCacheSakit>(clearCacheSakit);
    on<ClearPatchAndBase64>(clearPatchAndBase64);
  }

  Future<void> setPatchAndBase64(
    SetPathAndBase64 event,
    Emitter<SakitState> emit,
  ) async {
    emit(state.copyWith(path: () => event.path, base64: () => event.base64));
  }

  Future<void> clearPatchAndBase64(
    ClearPatchAndBase64 event,
    Emitter<SakitState> emit,
  ) async {
    emit(state.copyWith(path: () => null, base64: () => null));
  }

  Future<void> clearCacheSakit(
    ClearCacheSakit event,
    Emitter<SakitState> emit,
  ) async {
    event.startSakitController.clear();
    event.endSakitController.clear();
    event.keteranganSakitController.clear();
    emit(state.copyWith(path: () => null, base64: () => null));
  }

  Future<void> getHistorySakit(
    GetHistorySakit event,
    Emitter<SakitState> emit,
  ) async {
    try {
      final res = await listHistorySakit();

      emit(state.copyWith(listDataSakit: res));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> addSakitEvent(
    AddSakitEvent event,
    Emitter<SakitState> emit,
  ) async {
    print('masuk');
    if (event.startDate.isNotEmpty &&
        event.endDate.isNotEmpty &&
        state.base64 != null) {
      print('step 1 jalan');
      print('image = ${state.base64}');
      final dateFormat = DateFormat('dd/MM/yyyy');

      DateTime startDate = dateFormat.parse(event.startDate);
      DateTime endDate = dateFormat.parse(event.endDate);

      emit(state.copyWith(loadingAddSakit: true));
      try {
        final res = await addSakit(
          startDate: DateFormat('yyyy-MM-dd').format(startDate),
          endDate: DateFormat('yyyy-MM-dd').format(endDate),
          image: state.base64!,
          reason: event.reason,
        );

        if (res) {
          emit(
            state.copyWith(
              addSuccess: () => 'Sakit berhasil di ajukan',
              loadingAddSakit: false,
            ),
          );
          add(GetHistorySakit());
        } else {
          emit(
            state.copyWith(
              addFailed: () => 'Sakit gagal di ajukan',
              loadingAddSakit: false,
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            addFailed: () => 'Sakit gagal di ajukan',
            loadingAddSakit: false,
          ),
        );
      }
    }
  }
}

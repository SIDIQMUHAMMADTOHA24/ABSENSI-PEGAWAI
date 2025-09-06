import 'package:absensi_pegawai/features/absensi/domain/usecases/cuti/quota_cuti.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/quota.dart';

part 'cuti_event.dart';
part 'cuti_state.dart';

class CutiBloc extends Bloc<CutiEvent, CutiState> {
  final QuotaCuti quotaCuti;

  CutiBloc(this.quotaCuti) : super(CutiState()) {
    on<GetQuotaCuti>(getQuotaCuti);
  }

  Future<void> getQuotaCuti(GetQuotaCuti event, Emitter<CutiState> emit) async {
    try {
      Quota result = await quotaCuti();
      emit(state.copyWith(quotaCuti: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

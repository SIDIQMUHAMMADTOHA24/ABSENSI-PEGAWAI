import 'package:absensi_pegawai/features/absensi/domain/usecases/check_has_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/delete_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/save_token.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CheckHasToken checkHasToken;
  final SaveToken saveToken;
  final DeleteToken deleteToken;

  SessionBloc(this.checkHasToken, this.saveToken, this.deleteToken)
    : super(SessionInitial()) {
    on<CheckTokenEvent>(_checkHasToken);
    on<SaveTokenEvent>(_saveToken);
    on<DeleteTokenEvent>(_deleteToken);
  }

  _checkHasToken(CheckTokenEvent event, Emitter<SessionState> emit) async {
    final has = await checkHasToken();
    emit(has ? SessionAuthenticated() : SessionUnauthenticated());
  }

  _saveToken(SaveTokenEvent event, Emitter<SessionState> emit) async {
    await saveToken(event.refreshToken);
    emit(SessionAuthenticated());
  }

  _deleteToken(DeleteTokenEvent event, Emitter<SessionState> emit) async {
    await deleteToken();
    emit(SessionUnauthenticated());
  }
}

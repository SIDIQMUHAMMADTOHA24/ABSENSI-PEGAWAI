import 'package:absensi_pegawai/features/absensi/domain/usecases/auth/logout.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/delete_refresh_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/read_refresh_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/save_refresh_token.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/auth/login.dart';
import '../../../domain/usecases/auth/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUC;
  final Register registerUC;
  final Logout logoutUC;
  final ReadRefreshToken readRefreshTokenUC;
  final SaveRefreshToken saveRefreshTokenUC;
  final DeleteRefreshToken deleteRefreshTokenUC;
  AuthBloc({
    required this.loginUC,
    required this.registerUC,
    required this.logoutUC,
    required this.readRefreshTokenUC,
    required this.saveRefreshTokenUC,
    required this.deleteRefreshTokenUC,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await loginUC(
        username: event.username,
        password: event.password,
      );
      await saveRefreshTokenUC(result.refreshToken);
      emit(AuthLogIn('Login Success'));
    } catch (_) {
      emit(const AuthLogOut('Login Failed'));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await registerUC(
        username: event.username,
        password: event.password,
        jabatan: event.jabatan,
      );
      emit(const AuthLogIn('Register Success'));
    } catch (_) {
      emit(const AuthLogOut('Register Failed'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      String? res = await readRefreshTokenUC();
      if (res != null) {
        await logoutUC(res);
        await deleteRefreshTokenUC();
        emit(AuthLogOut("Logout"));
      }
    } catch (e) {
      emit(AuthInitial());
    }
  }
}

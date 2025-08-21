import 'package:absensi_pegawai/features/absensi/domain/entities/auth_result.dart';
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
  final SaveRefreshToken saveRefreshToken;
  AuthBloc({
    required this.loginUC,
    required this.registerUC,
    required this.saveRefreshToken,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await loginUC(
        username: event.username,
        password: event.password,
      );
      print('result = $result');
      await saveRefreshToken(result.refreshToken);
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
}

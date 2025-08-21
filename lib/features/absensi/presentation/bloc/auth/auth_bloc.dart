import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/login.dart' as uc_login;
import '../../../domain/usecases/register.dart' as uc_register;
import '../../../domain/usecases/save_token.dart' as uc_save_token;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final uc_login.Login loginUc;
  final uc_register.Register registerUc;
  final uc_save_token.SaveToken saveTokenUc;

  AuthBloc({
    required this.loginUc,
    required this.registerUc,
    required this.saveTokenUc,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await loginUc(
        uc_login.LoginParams(
          username: event.username,
          password: event.password,
        ),
      );
      emit(AuthLogIn('Asiiik, sudah masuk!'));
    } catch (e) {
      emit(AuthLogOut('Nice try cuy ahhah'));
    }
  }

  Future<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await registerUc(
        uc_register.RegisterParams(
          username: event.username,
          password: event.password,
          jabatan: event.jabatan,
        ),
      );
      emit(AuthLogIn('Akun lu dah dibuat, coba login dah'));
    } catch (e) {
      emit(AuthLogOut('Coba lagi dah'));
    }
  }
}

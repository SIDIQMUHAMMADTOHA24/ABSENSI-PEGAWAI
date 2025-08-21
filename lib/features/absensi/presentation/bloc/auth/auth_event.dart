part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RefreshEvent extends AuthEvent {
  const RefreshEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String jabatan;

  const RegisterEvent({
    required this.username,
    required this.password,
    required this.jabatan,
  });
  @override
  List<Object> get props => [username, password, jabatan];
}

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogIn extends AuthState {
  final String message;

  const AuthLogIn(this.message);
  @override
  List<Object> get props => [message];
}

class AuthLogOut extends AuthState {
  final String message;

  const AuthLogOut(this.message);
  @override
  List<Object> get props => [message];
}

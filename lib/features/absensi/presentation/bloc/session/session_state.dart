part of 'session_bloc.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class SessionInitial extends SessionState {}

final class SessionAuthenticated extends SessionState {}

final class SessionUnauthenticated extends SessionState {}

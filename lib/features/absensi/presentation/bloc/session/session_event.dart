part of 'session_bloc.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class CheckTokenEvent extends SessionEvent {
  const CheckTokenEvent();
}

class SaveTokenEvent extends SessionEvent {
  final String refreshToken;

  const SaveTokenEvent(this.refreshToken);
  @override
  List<Object> get props => [refreshToken];
}

class DeleteTokenEvent extends SessionEvent {
  const DeleteTokenEvent();
}

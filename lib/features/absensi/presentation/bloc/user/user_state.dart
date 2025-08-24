part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final User data;

  const UserSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

final class UserFailure extends UserState {}

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserHasData extends UserState {
  final User result;

  const UserHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class UserHasError extends UserState {
  final String message;

  const UserHasError({required this.message});

  @override
  List<Object> get props => [message];
}

class EditSuccessState extends UserState {
  final String message;

  const EditSuccessState(this.message);

  @override
  List<Object> get props => [message];
}

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final Auth? auth;
  final String? message;

  const AuthenticatedState({this.auth, this.message});

  @override
  List<Object> get props => [auth!, message!];
}

class UnAuthenticatedState extends AuthState {
  final String message;

  const UnAuthenticatedState(this.message);

  @override
  List<Object> get props => [message];
}

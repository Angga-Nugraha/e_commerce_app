part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class SignupEventClick extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  const SignupEventClick({
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });
  @override
  List<Object> get props => [
        email,
        username,
        password,
        name,
        address,
        phone,
      ];
}

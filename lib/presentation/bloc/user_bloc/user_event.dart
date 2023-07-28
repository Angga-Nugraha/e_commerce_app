part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUserById extends UserEvent {
  final int id;

  const FetchUserById({required this.id});

  @override
  List<Object> get props => [id];
}

class EditEventClick extends UserEvent {
  final int userId;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  const EditEventClick({
    required this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });
  @override
  List<Object> get props => [
        userId,
        email,
        username,
        password,
        name,
        address,
        phone,
      ];
}

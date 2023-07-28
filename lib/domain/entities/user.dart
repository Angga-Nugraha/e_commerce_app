import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        password,
        name,
        address,
        phone,
      ];
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/domain/repository/auth_repository.dart';

class EditUser {
  final AuthenticationRepository authenticationRepository;

  const EditUser({required this.authenticationRepository});

  Future<Either<Failure, String>> execute(
    int userId,
    String email,
    String username,
    String password,
    Name name,
    Address address,
    String phone,
  ) {
    return authenticationRepository.editUser(
      userId,
      email,
      username,
      password,
      name,
      address,
      phone,
    );
  }
}

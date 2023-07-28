import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:e_commerce_app/domain/repository/auth_repository.dart';

class GetUserById {
  final AuthenticationRepository authenticationRepository;

  const GetUserById({required this.authenticationRepository});

  Future<Either<Failure, User>> execute(int id) async {
    return authenticationRepository.getUserById(id);
  }
}

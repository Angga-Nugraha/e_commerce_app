import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/auth.dart';
import 'package:e_commerce_app/domain/repository/auth_repository.dart';

class Authenticated {
  final AuthenticationRepository authenticationRepository;

  Authenticated({required this.authenticationRepository});

  Future<Either<Failure, Auth>> execute(String username, String password) {
    return authenticationRepository.login(username, password);
  }
}

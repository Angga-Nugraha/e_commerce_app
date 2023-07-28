import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/auth.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Auth>> login(String username, String password);
  Future<Either<Failure, User>> getUserById(int id);
  Future<Either<Failure, int>> signUp(
    String email,
    String username,
    String password,
    Name name,
    Address address,
    String phone,
  );
  Future<Either<Failure, String>> editUser(
    int userId,
    String email,
    String username,
    String password,
    Name name,
    Address address,
    String phone,
  );
}

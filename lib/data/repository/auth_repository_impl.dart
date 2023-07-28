import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/data/datasource/authentication.dart';
import 'package:e_commerce_app/data/model/adress_model.dart';
import 'package:e_commerce_app/data/model/name_model.dart';
import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/auth.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:e_commerce_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthenticationRepository {
  final Authentication authentication;

  AuthRepositoryImpl({required this.authentication});

  @override
  Future<Either<Failure, Auth>> login(String username, String password) async {
    try {
      final result = await authentication.login(username, password);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("incorrect username/password"));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> signUp(String email, String username,
      String password, Name name, Address address, String phone) async {
    var kName = NameModel.fromJson(
        {"firstname": name.firstname, "lastname": name.lastname});

    var kAddress = AddressModel.fromJson({
      "city": address.city,
      "street": address.street,
      "number": address.number,
      "zipcode": address.zipcode,
      "geolocation": {
        "lat": address.geolocation.lat,
        "long": address.geolocation.long
      }
    });

    try {
      final result = await authentication.signUp(
          email, username, password, kName, kAddress, phone);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) async {
    try {
      final result = await authentication.getUserById(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> editUser(
    int userId,
    String email,
    String username,
    String password,
    Name name,
    Address address,
    String phone,
  ) async {
    var kName = NameModel.fromJson(
        {"firstname": name.firstname, "lastname": name.lastname});

    var kAddress = AddressModel.fromJson({
      "city": address.city,
      "street": address.street,
      "number": address.number,
      "zipcode": address.zipcode,
      "geolocation": {
        "lat": address.geolocation.lat,
        "long": address.geolocation.long
      }
    });

    try {
      final result = await authentication.editUser(
          userId, email, username, password, kName, kAddress, phone);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

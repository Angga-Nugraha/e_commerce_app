import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/data/datasource/location.dart';
import 'package:e_commerce_app/domain/repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GetLocationUser getLocationUser;
  LocationRepositoryImpl({required this.getLocationUser});

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final result = await getLocationUser.getCurrentLocation();
      return Right(result!);
    } on ServerException {
      return const Left(ServerFailure("i"));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

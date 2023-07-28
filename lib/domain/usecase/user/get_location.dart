import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation {
  final LocationRepository locationRepository;

  GetLocation({required this.locationRepository});

  Future<Either<Failure, Position>> execute() async {
    return await locationRepository.getCurrentLocation();
  }
}

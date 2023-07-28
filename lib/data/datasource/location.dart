import 'package:geolocator/geolocator.dart';

abstract class GetLocationUser {
  Future<Position?> getCurrentLocation();
}

class GetLocationUserImpl implements GetLocationUser {
  GetLocationUserImpl();

  @override
  Future<Position?> getCurrentLocation() async {
    Position? currentPosition;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      currentPosition = value;
    }).catchError((e) {
      throw e;
    });
    return currentPosition;
  }
}

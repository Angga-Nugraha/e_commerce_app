import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:e_commerce_app/data/common/style.dart';

class PermissionHelper {
  Future<bool> handleLocationPermission(BuildContext? context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        content: Text(
          "Location service are disable. Please enable the service",
          style: kSubTitle,
        ),
      ));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
            style: kSubTitle,
          ),
        ),
      );
      return false;
    }
    return true;
  }
}

final permission = PermissionHelper();

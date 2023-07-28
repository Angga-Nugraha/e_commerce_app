import 'package:e_commerce_app/domain/entities/geolocation.dart';
import 'package:equatable/equatable.dart';

class GeolocationModel extends Equatable {
  final String lat;
  final String long;

  const GeolocationModel({
    required this.lat,
    required this.long,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      GeolocationModel(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };

  Geolocation toEntity() => Geolocation(lat: lat, long: long);

  @override
  List<Object?> get props => [lat, long];
}

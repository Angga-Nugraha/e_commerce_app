import 'package:e_commerce_app/domain/entities/geolocation.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final Geolocation geolocation;

  const Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  @override
  List<Object?> get props => [
        city,
        street,
        number,
        zipcode,
        geolocation,
      ];
}

import 'package:e_commerce_app/data/model/geo_model.dart';
import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeolocationModel geolocation;

  const AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
        geolocation: GeolocationModel.fromJson(json["geolocation"]),
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
        "geolocation": geolocation.toJson(),
      };

  Address toEntity() => Address(
      city: city,
      street: street,
      number: number,
      zipcode: zipcode,
      geolocation: geolocation.toEntity());

  @override
  List<Object?> get props => [
        city,
        street,
        number,
        zipcode,
        geolocation,
      ];
}

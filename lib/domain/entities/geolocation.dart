import 'package:equatable/equatable.dart';

class Geolocation extends Equatable {
  final String lat;
  final String long;

  const Geolocation({
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}

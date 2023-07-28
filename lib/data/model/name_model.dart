import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:equatable/equatable.dart';

class NameModel extends Equatable {
  final String firstname;
  final String lastname;

  const NameModel({
    required this.firstname,
    required this.lastname,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
      };

  Name toEntity() => Name(firstname: firstname, lastname: lastname);

  @override
  List<Object?> get props => [firstname, lastname];
}

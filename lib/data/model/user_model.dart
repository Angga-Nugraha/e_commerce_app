// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:e_commerce_app/data/model/adress_model.dart';
import 'package:e_commerce_app/data/model/name_model.dart';
import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends Equatable {
  final int id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final AddressModel address;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: NameModel.fromJson(json["name"]),
        address: AddressModel.fromJson(json["address"]),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "name": name.toJson(),
        "address": address.toJson(),
        "phone": phone,
      };

  User toEntity() => User(
      id: id,
      email: email,
      username: username,
      password: password,
      name: name.toEntity(),
      address: address.toEntity(),
      phone: phone);

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        password,
        name,
        address,
        phone,
      ];
}

import 'dart:convert';
import 'package:e_commerce_app/data/common/const.dart';
import 'package:e_commerce_app/data/database/preference_helper.dart';
import 'package:e_commerce_app/data/model/adress_model.dart';
import 'package:e_commerce_app/data/model/name_model.dart';
import 'package:e_commerce_app/data/model/user_model.dart';
import 'package:http/http.dart' as http;

import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/model/auth_model.dart';

abstract class Authentication {
  Future<AuthModel> login(String username, String password);
  Future<UserModel> getUserById(int id);
  Future<int> signUp(
    String email,
    String username,
    String password,
    NameModel name,
    AddressModel address,
    String phone,
  );
  Future<String> editUser(
    int userId,
    String email,
    String username,
    String password,
    NameModel name,
    AddressModel address,
    String phone,
  );
}

class AuthenticationImpl implements Authentication {
  final http.Client client;

  AuthenticationImpl(this.client);

  @override
  Future<AuthModel> login(String username, String password) async {
    final response = await client.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );
    final data = Map<String, dynamic>.from(json.decode(response.body));
    preferencesHelper.saveToken(data['token']);

    if (response.statusCode == 200) {
      return AuthModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> signUp(
    String email,
    String username,
    String password,
    NameModel name,
    AddressModel address,
    String phone,
  ) async {
    final response = await client.post(Uri.parse("$baseUrl/users"),
        headers: {"content-Type": "application/json"},
        body: json.encode(
          {
            "email": email,
            "username": username,
            "password": password,
            "name": {
              "fisrtname": name.firstname,
              "lastname": name.lastname,
            },
            "address": {
              "city": address.city,
              "street": address.street,
              "number": address.number,
              "zipcode": address.zipcode,
              "geolocation": {
                "lat": address.geolocation.lat,
                "long": address.geolocation.long,
              },
            },
            "phone": phone,
          },
        ));

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return data['id'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/users/$id'));

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));
    if (response.statusCode == 200) {
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> editUser(
    int userId,
    String email,
    String username,
    String password,
    NameModel name,
    AddressModel address,
    String phone,
  ) async {
    final response = await client.put(Uri.parse("$baseUrl/users/$userId"),
        headers: {"content-Type": "application/json"},
        body: json.encode(
          {
            "email": email,
            "username": username,
            "password": password,
            "name": {
              "fisrtname": name.firstname,
              "lastname": name.lastname,
            },
            "address": {
              "city": address.city,
              "street": address.street,
              "number": address.number,
              "zipcode": address.zipcode,
              "geolocation": {
                "lat": address.geolocation.lat,
                "long": address.geolocation.long,
              },
            },
            "phone": phone,
          },
        ));

    // final Map<String, dynamic> data =
    //     Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return "User updated";
    } else {
      throw ServerException();
    }
  }
}

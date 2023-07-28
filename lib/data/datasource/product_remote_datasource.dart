import 'dart:convert';

import 'package:e_commerce_app/data/common/const.dart';
import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/database/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/data/model/product_model.dart';

import '../model/cart_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProduct();
  Future<List<ProductModel>> getProductCategories(String query);
  Future<ProductModel> getSingleProduct(int id);
  Future<List<CartModel>> getMyOrderCart(int userId);
  Future<String> createNewOrder(CartModel cart);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client client;

  ProductRemoteDatasourceImpl(this.client);

  @override
  Future<List<ProductModel>> getAllProduct() async {
    var response = await client.get(Uri.parse("$baseUrl/products"));

    List<ProductModel> listProduct = productModelFromJson(response.body);

    if (response.statusCode == 200) {
      return listProduct;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getSingleProduct(int id) async {
    var response = await client.get(Uri.parse("$baseUrl/products/$id"));

    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProductCategories(String query) async {
    var response =
        await client.get(Uri.parse("$baseUrl/products/category/$query"));

    List<ProductModel> listProduct = productModelFromJson(response.body);

    if (response.statusCode == 200) {
      return listProduct;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CartModel>> getMyOrderCart(int userId) async {
    var response = await client.get(Uri.parse("$baseUrl/carts/user/$userId"));
    List<CartModel> data = cartModelFromJson(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> createNewOrder(CartModel cart) async {
    final response = await client.post(
      Uri.parse('$baseUrl/carts'),
      headers: {"content-Type": "application/json"},
      body: json.encode(cart.toJson()),
    );

    if (response.statusCode == 200) {
      await databaseHelper.deleteAllProductCart();
      return 'Order Created';
    } else {
      throw ServerException();
    }
  }
}

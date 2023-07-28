// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel extends Equatable {
  final int id;
  final int userId;
  final String date;
  final List<ProductCartModel> products;

  const CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        date: json["date"],
        products: List<ProductCartModel>.from(
            json["products"].map((x) => ProductCartModel.fromJson(x))),
      );

  factory CartModel.fromEntity(Cart cart) => CartModel(
      id: cart.id,
      userId: cart.userId,
      date: cart.date,
      products: List<ProductCartModel>.generate(
        cart.products.length,
        (index) => ProductCartModel.fromEntity(cart.products[index]),
      ).toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };

  Cart toEntity() => Cart(
      id: id,
      userId: userId,
      date: date.toString(),
      products: products.map((e) => e.toEntity()).toList());

  @override
  List<Object?> get props => [id, userId, date, products];
}

class ProductCartModel extends Equatable {
  final int productId;
  final int quantity;

  const ProductCartModel({
    required this.productId,
    required this.quantity,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      ProductCartModel(
        productId: json["productId"],
        quantity: json["quantity"],
      );
  factory ProductCartModel.fromEntity(Product product) =>
      ProductCartModel(productId: product.id, quantity: product.quantity);

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };

  Product toEntity() => Product.orderCart(id: productId, quantity: quantity);

  @override
  List<Object?> get props => [productId, quantity];
}

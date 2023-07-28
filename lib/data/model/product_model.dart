// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:e_commerce_app/data/model/rating_model.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore: must_be_immutable
class ProductModel extends Equatable {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  RatingModel? rating;
  int? quantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: RatingModel.fromJson(json["rating"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating!.toJson(),
        "quantity": quantity,
      };

  Product toEntity() => Product(
        id: id!,
        title: title!,
        price: price!,
        description: description!,
        category: category!,
        image: image!,
        rating: rating!.toEntity(),
        // quantity: quantity!,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
        quantity,
      ];
}

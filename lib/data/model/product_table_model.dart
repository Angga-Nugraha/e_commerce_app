import 'dart:convert';

import 'package:e_commerce_app/data/model/rating_model.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class TableProduct extends Equatable {
  final int id;
  final String title;
  final String category;
  final String description;
  final String image;
  final double price;
  final String rating;
  final int quantity;

  const TableProduct({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    this.quantity = 0,
  });

  factory TableProduct.fromEntity(Product product) => TableProduct(
      id: product.id,
      title: product.title!,
      category: product.category!,
      description: product.description!,
      image: product.image!,
      price: product.price!,
      rating: json.encode(RatingModel.fromEntity(product.rating!)),
      quantity: product.quantity);

  factory TableProduct.fromMap(Map<String, dynamic> map) => TableProduct(
        id: map['id'],
        title: map['title'],
        category: map['category'],
        description: map['description'],
        image: map['image'],
        price: map['price'],
        rating: map['rating'],
        quantity: map['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'description': description,
        'image': image,
        'price': price,
        'rating': rating,
        'quantity': quantity,
      };

  Product toEntity() => Product.cartList(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: RatingModel.fromJson(json.decode(rating)).toEntity(),
        quantity: quantity,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        description,
        image,
        price,
        rating,
        quantity,
      ];
}

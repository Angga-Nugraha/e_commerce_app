import 'package:e_commerce_app/domain/entities/rating.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  final int id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 0,
  });

  Product.cartList({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity = 0,
  });

  Product.orderCart({
    required this.id,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        category,
        description,
        image,
        rating,
        quantity,
      ];
}

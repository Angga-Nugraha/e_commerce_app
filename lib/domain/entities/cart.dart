import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final int id;
  final int userId;
  final String date;
  final List<Product> products;

  const Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  @override
  List<Object?> get props => [id, userId, date, products];
}

// class ProductCart extends Equatable {
//   final int productId;
//   final int quantity;

//   const ProductCart({
//     required this.productId,
//     required this.quantity,
//   });

//   @override
//   List<Object?> get props => [productId, quantity];
// }

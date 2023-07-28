import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class CreateNewOrder {
  ProductRepository productRepository;

  CreateNewOrder({required this.productRepository});

  Future<Either<Failure, String>> execute(Cart cart) async {
    return productRepository.createNewOrder(cart);
  }
}

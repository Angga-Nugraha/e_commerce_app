import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetMyOrderCart {
  ProductRepository productRepository;

  GetMyOrderCart({required this.productRepository});

  Future<Either<Failure, List<Cart>>> execute(int userId) async {
    return productRepository.getMyOrderCart(userId);
  }
}

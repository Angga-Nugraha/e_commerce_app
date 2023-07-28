import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class RemoveFromFavorite {
  ProductRepository productRepository;

  RemoveFromFavorite({required this.productRepository});

  Future<Either<Failure, String>> execute(Product product) {
    return productRepository.removeFromFavorite(product);
  }
}

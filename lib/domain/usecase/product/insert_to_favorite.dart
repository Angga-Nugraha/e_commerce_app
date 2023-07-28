import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class InsertToFavorite {
  ProductRepository productRepository;

  InsertToFavorite({required this.productRepository});

  Future<Either<Failure, String>> execute(Product product) {
    return productRepository.insertToFavorite(product);
  }
}

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetProductCategory {
  final ProductRepository productRepository;

  GetProductCategory({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute(String query) {
    return productRepository.getProductCategories(query);
  }
}

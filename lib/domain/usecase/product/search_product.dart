import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class SearchProduct {
  ProductRepository productRepository;

  SearchProduct({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute(String query) async {
    return productRepository.searchProduct(query);
  }
}

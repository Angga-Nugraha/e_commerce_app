import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetSingleProduct {
  final ProductRepository productRepository;

  const GetSingleProduct({required this.productRepository});

  Future<Either<Failure, Product>> execute(int id) {
    return productRepository.getSingleProduct(id);
  }
}

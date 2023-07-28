import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetAllProduct {
  final ProductRepository productRepository;

  GetAllProduct({required this.productRepository});

  Future<Either<Failure, List<Product>>> execute() {
    return productRepository.getAllproduct();
  }
}

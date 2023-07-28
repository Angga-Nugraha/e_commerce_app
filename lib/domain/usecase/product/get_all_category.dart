import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetAllCategory {
  ProductRepository productRepository;

  GetAllCategory({required this.productRepository});

  Future<Either<Failure, List<String>>> execute() async {
    return productRepository.getAllCategoryProduct();
  }
}

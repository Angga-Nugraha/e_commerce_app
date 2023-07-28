import 'package:e_commerce_app/domain/repository/product_repository.dart';

class GetProductStatus {
  ProductRepository productRepository;

  GetProductStatus({required this.productRepository});

  Future<bool> execute(int id) {
    return productRepository.isAddedFromFavorite(id);
  }
}

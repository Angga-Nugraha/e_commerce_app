import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllproduct();
  Future<Either<Failure, List<Product>>> getTopRatedProduct();
  Future<Either<Failure, List<String>>> getAllCategoryProduct();
  Future<Either<Failure, List<Product>>> getProductCategories(String query);
  Future<Either<Failure, List<Product>>> searchProduct(String query);
  Future<Either<Failure, Product>> getSingleProduct(int id);
  Future<Either<Failure, String>> insertToCart(Product product);
  Future<Either<Failure, String>> removeFromCart(Product product);
  Future<Either<Failure, List<Product>>> getListCart();
  Future<Either<Failure, String>> insertToFavorite(Product product);
  Future<Either<Failure, String>> removeFromFavorite(Product product);
  Future<Either<Failure, List<Product>>> getListFavorite();
  Future<bool> isAddedFromFavorite(int id);
  Future<Either<Failure, List<Cart>>> getMyOrderCart(int userId);
  Future<Either<Failure, String>> createNewOrder(Cart cart);
}

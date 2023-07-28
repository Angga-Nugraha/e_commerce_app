import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/common/failure.dart';
import 'package:e_commerce_app/data/datasource/product_local_datasource.dart';
import 'package:e_commerce_app/data/datasource/product_remote_datasource.dart';
import 'package:e_commerce_app/data/model/cart_model.dart';
import 'package:e_commerce_app/data/model/product_table_model.dart';
import 'package:e_commerce_app/domain/entities/cart.dart';
import 'package:e_commerce_app/domain/entities/product.dart';
import 'package:e_commerce_app/domain/repository/product_repository.dart';
import 'package:flutter/material.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;
  final ProductLocalDatasource productLocalDatasource;

  ProductRepositoryImpl({
    required this.productRemoteDatasource,
    required this.productLocalDatasource,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllproduct() async {
    try {
      final result = await productRemoteDatasource.getAllProduct();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(int id) async {
    try {
      final result = await productRemoteDatasource.getSingleProduct(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductCategories(
      String query) async {
    try {
      final result = await productRemoteDatasource.getProductCategories(query);

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getTopRatedProduct() async {
    try {
      final result = await productRemoteDatasource.getAllProduct();
      final finalResult = result
          .map((element) => element.toEntity())
          .where((element) => element.rating!.rate > 4)
          .toList();
      return Right(finalResult);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProduct(String query) async {
    try {
      final result = await productRemoteDatasource.getAllProduct();
      final searchResult = result
          .map((element) => element.toEntity())
          .where(
            (element) =>
                element.title!.toLowerCase().contains(query.toLowerCase()) ||
                element.category!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      return Right(searchResult);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getListCart() async {
    final result = await productLocalDatasource.getListCart();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> insertToCart(Product product) async {
    try {
      final result = await productLocalDatasource
          .insertToCart(TableProduct.fromEntity(product));
      debugPrint(result);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromCart(Product product) async {
    try {
      final result = await productLocalDatasource
          .removeFromCart(TableProduct.fromEntity(product));
      debugPrint(result);

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getListFavorite() async {
    final result = await productLocalDatasource.getListFavorite();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<Either<Failure, String>> insertToFavorite(Product product) async {
    try {
      final result = await productLocalDatasource
          .insertToFavorite(TableProduct.fromEntity(product));
      debugPrint(result);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<bool> isAddedFromFavorite(int id) async {
    final result = await productLocalDatasource.getProductById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeFromFavorite(Product product) async {
    try {
      final result = await productLocalDatasource
          .removeFromFavorite(TableProduct.fromEntity(product));
      debugPrint(result);

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> getMyOrderCart(int userId) async {
    try {
      final result = await productRemoteDatasource.getMyOrderCart(userId);
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createNewOrder(Cart cart) async {
    try {
      final result = await productRemoteDatasource
          .createNewOrder(CartModel.fromEntity(cart));
      debugPrint(result);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllCategoryProduct() async {
    try {
      final result = await productRemoteDatasource.getAllProduct();
      final allCategory = result.map((e) => e.category!).toList();
      return Right(allCategory);
    } on ServerException {
      return const Left(ServerFailure(""));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}

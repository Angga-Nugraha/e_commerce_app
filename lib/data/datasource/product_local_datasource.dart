import 'package:e_commerce_app/data/common/exception.dart';
import 'package:e_commerce_app/data/database/database_helper.dart';
import 'package:e_commerce_app/data/model/product_table_model.dart';

abstract class ProductLocalDatasource {
  Future<String> insertToCart(TableProduct product);
  Future<String> removeFromCart(TableProduct product);
  Future<List<TableProduct>> getListCart();
  Future<String> insertToFavorite(TableProduct product);
  Future<TableProduct?> getProductById(int id);
  Future<String> removeFromFavorite(TableProduct product);
  Future<List<TableProduct>> getListFavorite();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  @override
  Future<List<TableProduct>> getListCart() async {
    final cart = await databaseHelper.getListCart();
    return cart.map((e) => TableProduct.fromMap(e)).toList();
  }

  @override
  Future<String> insertToCart(TableProduct product) async {
    try {
      await databaseHelper.insertTocart(product);
      return 'Add to cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFromCart(TableProduct product) async {
    try {
      await databaseHelper.removeFromCart(product);
      return 'Remove from cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TableProduct>> getListFavorite() async {
    final cart = await databaseHelper.getListFavorite();
    return cart.map((e) => TableProduct.fromMap(e)).toList();
  }

  @override
  Future<TableProduct?> getProductById(int id) async {
    final result = await databaseHelper.getProductById(id);
    if (result != null) {
      return TableProduct.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<String> insertToFavorite(TableProduct product) async {
    try {
      await databaseHelper.insertToFavorite(product);
      return 'Add to favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFromFavorite(TableProduct product) async {
    try {
      await databaseHelper.removeFromFavorite(product);
      return 'Remove from favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

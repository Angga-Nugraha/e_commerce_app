import 'package:e_commerce_app/data/common/encrypt.dart';
import 'package:e_commerce_app/data/model/product_table_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDB();
    return _database;
  }

  static const String _tableCart = "tbCart";
  static const String _tableFav = "tbFavorite";

  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final databasePath = "$path/ecommerce.db";

    debugPrint(databasePath);

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt("your secure password"),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_tableCart(
      id INTEGER PRIMARY KEY,
      title TEXT,
      category TEXT,
      description TEXT,
      image TEXT,
      price REAL,
      rating BLOB,
      quantity INTEGER
    );
    ''');
    await db.execute('''
    CREATE TABLE $_tableFav(
      id INTEGER PRIMARY KEY,
      title TEXT,
      category TEXT,
      description TEXT,
      image TEXT,
      price REAL,
      rating BLOB,
      quantity INTEGER
    );
    ''');
  }

  Future<int> insertTocart(TableProduct product) async {
    final db = await database;
    return await db!.insert(
      _tableCart,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertToFavorite(TableProduct product) async {
    final db = await database;
    return await db!.insert(
      _tableFav,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> removeFromCart(TableProduct product) async {
    final db = await database;
    return await db!.delete(
      _tableCart,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteAllProductCart() async {
    final db = await database;
    return await db!.delete(_tableCart);
  }

  Future<int> removeFromFavorite(TableProduct product) async {
    final db = await database;
    return await db!.delete(
      _tableFav,
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<Map<String, dynamic>?> getProductById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tableFav,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getListCart() async {
    final db = await database;
    final List<Map<String, dynamic>> cart = await db!.query(_tableCart);

    return cart;
  }

  Future<List<Map<String, dynamic>>> getListFavorite() async {
    final db = await database;
    final List<Map<String, dynamic>> favorite = await db!.query(_tableFav);

    return favorite;
  }
}

final databaseHelper = DatabaseHelper();

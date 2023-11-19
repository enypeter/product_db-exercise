import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:payble_flutter_test/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabaseHelper {
  static Database? _productDb;
  static ProductDatabaseHelper? _productDatabaseHelper;

  String table = 'productTable';
  String cartTable = 'cartTable';
  String colId = 'id';
  String colName = 'name';
  String colDescription = "description";
  String colCostPrice = "cost_price";
  String colSellingPrice = "selling_price";
  String colQuantity = "quantity";
  String colImage = 'image';
  ProductDatabaseHelper._createInstance();

  static final ProductDatabaseHelper db =
  ProductDatabaseHelper._createInstance();

  factory ProductDatabaseHelper() {
    _productDatabaseHelper ??= ProductDatabaseHelper._createInstance();
    return _productDatabaseHelper!;
  }

  Future<Database> get database async {
    _productDb ??= await initializeDatabase();
    return _productDb!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}products.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute("CREATE TABLE $table"
        "($colId $idType,"
        "$colName $textType, $colDescription $textType, $colCostPrice $textType, $colSellingPrice $textType, $colQuantity $textType, $colImage $textType)");
  }

  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }


  Future<int> insertProduct(Product product, {cart = false}) async {
    Database db = await database;
    var result = await db.insert(cart ? cartTable : table, product.toJson());
    log(result.toString());
    return result;
  }

  Future<int> updateProduct(Product product, {cart = false}) async {
    var db = await database;
    var result = await db.update(cart ? cartTable : table, product.toJson(),
        where: '$colId = ?', whereArgs: [product.id]);
    return result;
  }

  Future<int> deleteProduct(int id, {cart = false}) async {
    var db = await database;
    int result = await db
        .delete(cart ? cartTable : table, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int?> getCount(tableName) async {
    Database db = await database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $tableName');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Product>> getProductList() async {
    var productMapList = await getProductMapList();
    int? count = await getCount(table);

    List<Product> productList = <Product>[];
    for (int i = 0; i < count!; i++) {
      productList.add(Product.fromJson(productMapList[i]));
    }
    return productList;
  }


  close() async {
    var db = await database;
    var result = db.close();
    return result;
  }
}

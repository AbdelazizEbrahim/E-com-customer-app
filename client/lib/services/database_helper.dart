import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class DatabaseHelper {
  static const _databaseName = 'cart.db';
  static const _databaseVersion = 1;
  static const cartTable = 'cart_items';
  static const orderTable = 'orders';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        productId TEXT PRIMARY KEY,
        name TEXT,
        price REAL,
        image TEXT,
        quantity INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE $orderTable (
        id TEXT PRIMARY KEY,
        items TEXT,
        totalPrice REAL,
        shippingName TEXT,
        shippingAddress TEXT,
        city TEXT,
        postalCode TEXT,
        shippingPhone TEXT,
        userId TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await database;
    await db.insert(
      cartTable,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(cartTable);
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }

  Future<void> updateCartItem(CartItem item) async {
    final db = await database;
    await db.update(
      cartTable,
      item.toMap(),
      where: 'productId = ?',
      whereArgs: [item.productId],
    );
  }

  Future<void> deleteCartItem(String productId) async {
    final db = await database;
    await db.delete(cartTable, where: 'productId = ?', whereArgs: [productId]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete(cartTable);
  }

  Future<void> insertOrder(Order order) async {
    final db = await database;
    await db.insert(
      orderTable,
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Order>> getOrders(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      orderTable,
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
  }
}

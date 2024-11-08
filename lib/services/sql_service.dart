import 'package:flutter/foundation.dart';
import 'package:lista_de_compras_simples/models/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlService {
  static Database? db;

  static Future<void> initDatabase() async {
    const path = 'items.db';
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      db = await databaseFactory.openDatabase(path);
    } else {
      db = await openDatabase(path);
    }
    await db!.execute('''
      CREATE TABLE IF NOT EXISTS items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        purchased INTEGER
      )
    ''');
  }

  static Future<void> addOne(ItemModel model) async {
    await db!.insert('items', {
      'name': model.name,
      'quantity': model.quantity,
      'purchased': model.purchased ? 1 : 0,
    });
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    return await db!.query('items');
  }
}

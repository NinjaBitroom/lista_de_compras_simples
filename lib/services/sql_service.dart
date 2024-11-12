import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lista_de_compras_simples/models/item_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class SqlService extends GetxService {
  late Database db;

  Future<SqlService> init() async {
    sqfliteFfiInit();
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (GetPlatform.isWindows) {
      databaseFactory = databaseFactoryFfi;
    }
    db = await openDatabase('items.db');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        purchased INTEGER
      )
    ''');
    return this;
  }

  Future<void> addOne(ItemModel model) async {
    await db.insert('items', {
      'name': model.name,
      'quantity': model.quantity,
      'purchased': model.purchased ? 1 : 0,
    });
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    return await db.query('items');
  }
}

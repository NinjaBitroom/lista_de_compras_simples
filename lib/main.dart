import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_compras_simples/controllers/item_controller.dart';
import 'package:lista_de_compras_simples/services/sql_service.dart';

import 'main/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlService.initDatabase();
  Get.put(ItemController());
  runApp(const App());
}

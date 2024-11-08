import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_compras_simples/views/home_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeView(),
    );
  }
}

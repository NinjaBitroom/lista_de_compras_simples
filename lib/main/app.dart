import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_compras_simples/utils/app_theme.dart';
import 'package:lista_de_compras_simples/views/home_view.dart';

class App extends GetWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(lightDynamic?.primary),
        darkTheme: AppTheme.dark(darkDynamic?.primary),
        home: HomeView(),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_de_compras_simples/controllers/item_controller.dart';
import 'package:rive/rive.dart' as rive;

class HomeView extends GetView<ItemController> {
  HomeView({super.key});

  final addItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        actions: [
          IconButton(
            onPressed: () {
              controller.print();
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: controller.obx(
        (state) => ListView.builder(
          itemCount: state?.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(state![index].name),
                subtitle: Text('Quantidade: ${state[index].quantity}'),
              ),
            );
          },
        ),
        onEmpty: const Text('Nenhum item na lista'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            content: Column(
              children: [
                const SizedBox(
                  height: 256,
                  child: rive.RiveAnimation.asset(
                    'animations/shopping_cart.riv',
                  ),
                ),
                TextField(controller: addItemController),
                FilledButton(
                  onPressed: () {
                    controller.addOne(addItemController.text);
                    Get.back();
                    addItemController.clear();
                  },
                  child: const Text('Adicionar'),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

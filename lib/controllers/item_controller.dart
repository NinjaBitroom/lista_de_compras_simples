import 'package:get/get.dart';
import 'package:lista_de_compras_simples/models/item_model.dart';
import 'package:lista_de_compras_simples/services/sql_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ItemController extends GetxController with StateMixin<List<ItemModel>> {
  @override
  Future<void> onInit() async {
    super.onInit();
    final itemsFromDb = await SqlService.getAll();
    final items = itemsFromDb.map((e) => ItemModel.fromMap(e)).toList();
    if (items.isEmpty) {
      change(null, status: RxStatus.empty());
      return;
    }
    change(items, status: RxStatus.success());
  }

  Future<void> addOne(String name) async {
    final item = ItemModel(name: name, quantity: 1, purchased: false);
    await SqlService.addOne(item);
    final itemsFromDb = await SqlService.getAll();
    final items = itemsFromDb.map((e) => ItemModel.fromMap(e)).toList();
    change(items, status: RxStatus.success());
  }

  Future<void> print() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(
          child: pw.ListView.builder(
            itemCount: state!.length,
            itemBuilder: (context, index) {
              return pw.Column(
                children: [
                  pw.Text(state![index].name),
                  pw.Text('Quantidade: ${state![index].quantity}'),
                  pw.Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}

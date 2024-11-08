class ItemModel {
  String name;
  int quantity;
  bool purchased;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.purchased,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'],
      quantity: map['quantity'],
      purchased: map['purchased'] == 1,
    );
  }
}

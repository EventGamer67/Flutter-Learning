class Item {
  final String? itemID;
  final String? item_categoryID;
  final String? item_name;
  final double? item_price;
  final List<String>? item_image;

  Item({
    this.itemID,
    this.item_categoryID,
    this.item_name,
    this.item_price,
    this.item_image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemID: json['itemID'],
      item_categoryID: json['item_categoryID'],
      item_name: json['item_name'],
      item_price: json['item_price']?.toDouble(),
      item_image: (json['item_image'] as List<dynamic>)?.map((image) => image.toString()).toList(),
    );
  }
}

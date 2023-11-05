// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'Item.g.dart';

@JsonSerializable()
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
}

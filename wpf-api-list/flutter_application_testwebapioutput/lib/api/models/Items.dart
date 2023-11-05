import 'package:json_annotation/json_annotation.dart';

part 'Items.g.dart';
part 'api.g.dart';

@JsonSerializable()
class Items {
  const Items({this.itemID, this.item_categoryID, this.item_name, this.item_price, this.item_image});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  final String? itemID;
  final String? item_categoryID;
  final String? item_name;
  final double? item_price;
  final List<String>? item_image;

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
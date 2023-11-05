// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      itemID: json['itemID'] as String?,
      item_categoryID: json['item_categoryID'] as String?,
      item_name: json['item_name'] as String?,
      item_price: (json['item_price'] as num?)?.toDouble(),
      item_image: (json['item_image'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'itemID': instance.itemID,
      'item_categoryID': instance.item_categoryID,
      'item_name': instance.item_name,
      'item_price': instance.item_price,
      'item_image': instance.item_image,
    };

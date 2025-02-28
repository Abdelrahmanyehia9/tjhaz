import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/utils/app_localization.dart';

class ProductModel {
  final String id;
  final String description;
  final bool? featured;
  final List<String> images;
  final String name;
  final String vendor;
  final double price;
  final double? priceBeforeDiscount;
  final List<String>? tags;

  ProductModel({
    required this.id,
    required this.description,
    this.featured,
    required this.images,
    required this.name,
    required this.vendor,
    required this.price,
    this.priceBeforeDiscount,
    this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ,
      description: (json['description'] as Map<String, dynamic>).localized ,
      featured: json['featured'] as bool?,
      images: (json['images'] as List<dynamic>).map((e) => e.toString()).toList() ,
      name: (json['name'] as Map<String, dynamic>).localized,
      vendor: json['parent_id'],
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      priceBeforeDiscount: (json['price_before_discount'] is num)
          ? (json['price_before_discount'] as num).toDouble()
          : double.tryParse(json['price_before_discount']?.toString() ?? ''),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>?)?.localized)
          .where((e) => e != null)
          .cast<String>()
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'featured': featured,
      'images': images,
      'name': name,
      'parent_id': vendor,
      'price': price,
      'price_before_discount': priceBeforeDiscount,
      'tags': tags,
    };
  }
}

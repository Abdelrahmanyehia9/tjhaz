import 'package:equatable/equatable.dart';
import 'package:tjhaz/core/extention/localized_map.dart';

class VendorModel extends Equatable {
  final String id;
  final List<String>? categories;
  final String description;
  final Map<String, dynamic> shippingTime;
  final String? location;
  final bool? featured;
  final List<String> images;
  final String name;
  final double? rates;
  final double shippingCost;
  final int? ratingCount;

  const VendorModel({
    required this.id,
    this.categories,
    required this.description,
    required this.shippingTime,
    this.location,
    required this.shippingCost,
    this.featured,
    required this.images,
    required this.name,
    this.rates,
    this.ratingCount,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'] ,
      description: (json['description'] as Map<String, dynamic>?)?.localized ?? '',
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => (e as Map<String, dynamic>?)?.localized)
          .where((e) => e != null)
          .cast<String>()
          .toList(),
      featured: json['featured'] as bool?,
      images: List<String>.from(json["images"]),
      name: (json['name'] as Map<String, dynamic>).localized,
      shippingCost: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      rates: (json['rates'] is num) ? (json['rates'] as num).toDouble() : double.tryParse(json['rates']?.toString() ?? ''),
      ratingCount: (json['rating_count'] is int) ? json['rating_count'] as int : int.tryParse(json['rating_count']?.toString() ?? ''),
      shippingTime: {
        'from': json['shipping_time']?['from'],
        'to': json['shipping_time']?['to'],
      },
      location: (json['location'] as Map<String, dynamic>?)?.localized,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'category': categories,
      'featured': featured,
      'images': images,
      'name': name,
      'price': shippingCost,
      'rates': rates,
      'rating_count': ratingCount,
      'shipping_time': shippingTime,
      'location': location,
    };
  }

  @override
  List<Object?> get props => [
    id,
    categories,
    description,
    shippingTime,
    location,
    featured,
    images,
    name,
    rates,
    shippingCost,
    ratingCount
  ];
}

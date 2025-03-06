import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/utils/app_strings.dart';

class EntertainmentDetailsModel {
  final String id;
  final String name;
  final String categoryID;
  final String location;
  final String description;
  final String entertainmentType;
  final List<AddonsModel>? addOns ;
  final String? details;
  final int  availableFrom;
  final int availableTo ;
  final int minHoursToBooking;
  final List<String> images;
  final double price;
  final int? guests;
  final String rates;
  final int ratingCount;
  final Map<String, dynamic>? facilities;
  final List<String>? comfortFacilities;

  EntertainmentDetailsModel({
   required this.availableFrom  ,
    required this.availableTo ,
    required this.minHoursToBooking ,
    this.addOns ,
    required this.id,
    required this.name,
    required this.categoryID,
    required this.location,
    required this.description,
    required this.entertainmentType,
     this.details,
    required this.images,
    required this.price,
      this.guests,
    required this.rates,
    required this.ratingCount,
    this.facilities,
    this.comfortFacilities,
  });

  factory EntertainmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EntertainmentDetailsModel(
      id: json["id"] ?? '',
      addOns: json['addons'] != null
          ? List<AddonsModel>.from(json['addons'].map((x) => AddonsModel.fromJson(x)))
          : [], availableFrom:  json["available_from"] ?? 10,
      availableTo:  json["available_to"] ?? 22,
      minHoursToBooking:  json["min_hours_to_booking"] ?? 1,
      name: (json["name"] as Map<String, dynamic>).localized,
      location: (json["location"] as Map<String, dynamic>?)?.localized ?? AppStrings.notSpecified,
      description: (json["description"] as Map<String, dynamic>).localized ,
      details: (json["details"] as Map<String, dynamic>?)?.localized ,
      entertainmentType: json["entertainment_type"] ,
      categoryID: json["category_id"] ,
      images: (json["images"] as List<dynamic>).map((e) => e.toString()).toList(),
      guests: json["guests"] ,
      price: json["price"] is num
          ? (json["price"] as num).toDouble()
          : (json["price"] != null ? double.tryParse(json["price"].toString()) : 0.0) ?? 0.0,
      rates: json["rates"]?.toString() ?? AppStrings.notRated,
      ratingCount: json["rating_count"] is int ? json["rating_count"] as int : int.tryParse(json["rating_count"]?.toString() ?? '0') ?? 0,
      facilities: json["Facilities"] as Map<String, dynamic>?,
      comfortFacilities: (json["comfort_Facilities"] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "entertainment_type": entertainmentType,
      "location": location,
      "description": description,
      "details": details,
      "category_id": categoryID,
      "images": images,
      "guests": guests,
      "price": price,
      "rates": rates,
      "rating_count": ratingCount,
      "Facilities": facilities,
      "comfort_Facilities": comfortFacilities,
    };
  }
}



class AddonsModel {
  final String? title;
  final String? img ;
  final String? price;
  AddonsModel(this.img  , this.title , this.price)  ;
  factory AddonsModel.fromJson(Map<String, dynamic> json) {
    return AddonsModel(json['image'] , (json['name']as Map<String , dynamic>).localized , json['price'] );
  }


}
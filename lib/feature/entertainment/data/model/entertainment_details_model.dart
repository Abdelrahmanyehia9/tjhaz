class EntertainmentDetailsModel {
  final String id;
  final Map<String, String> name;
  final String categoryID ;
  final Map<String, String>? location;
  final Map<String, String> description;
  final String entertainmentType;
  final Map<String, String>? details;
  final List<String> images;
  final String price ;
  final String time;
  final int? guests;
  final String rates;
  final int ratingCount;
  final Map<String, dynamic>? facilities;
  final List<String>? comfortFacilities;

  EntertainmentDetailsModel({
    required this.categoryID,
    required this.entertainmentType ,
    required this.id,
    required this.name,
    this.location,
    required this.price,
   required this.description,
    this.details,
    required this.images,
    required this.time,
    this.guests,
    required this.rates,
    required this.ratingCount,
    this.facilities,
    this.comfortFacilities,
  });

  factory EntertainmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return EntertainmentDetailsModel(
      entertainmentType: json["entertainment_type"],
      id: json["id"],
      name: Map<String, String>.from(json["name"]),
      location: json["location"] != null ? Map<String, String>.from(json["location"]) : null,
      description: Map<String, String>.from(json["description"]) ,
      details: json["details"] != null ? Map<String, String>.from(json["details"]) : null,
      images: List<String>.from(json["images"]),
      time: json["time"],
      guests: json["guests"],
      categoryID: json["category_id"],
      rates: json["rates"],
      price: json["price"],
      ratingCount: json["rating_count"],
      facilities: json["Facilities"] != null ? Map<String, dynamic>.from(json["Facilities"]) : null,
      comfortFacilities: json["comfort_Facilities"] != null ? List<String>.from(json["comfort_Facilities"]) : null,
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
      "category_id":categoryID,
      "images": images,
      "time": time,
      "guests": guests,
      "rates": rates,
      "rating_count": ratingCount,
      "Facilities": facilities,
      "comfort_Facilities": comfortFacilities,
      "price": price
    };
  }
}

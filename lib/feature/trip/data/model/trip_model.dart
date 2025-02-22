class TripModel {
  final String tripId;
  final Map<String, String> name;
  final String price;
  final Map<String, String>? location;
  final List<String> images;
  final int? ratingCount;
  final String? rating;
  final String tripTime;
  final List<String> facilities;
  final List<String> comfortFacilities;
  final int? numOfGusts;
  final Map<String, String> description;

  TripModel({
    required this.tripId,
    required this.name,
    required this.price,
    this.location,
    required this.images,
    this.ratingCount,
    this.rating,
    required this.tripTime,
    required this.facilities,
    required this.comfortFacilities,
    this.numOfGusts,
    required this.description,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    tripId: json["id"],
    name: Map<String, String>.from(json["name"]),
    price: json["price"],
    images: List<String>.from(json["images"]),
    tripTime: json["time"],
    facilities: List<String>.from(json["Facilities"]),
    comfortFacilities: List<String>.from(json["comfort_Facilities"]),
    description: Map<String, String>.from(json["description"]),
    location: json["location"] != null
        ? Map<String, String>.from(json["location"])
        : null,
    ratingCount: json["rating_count"],
    rating: json["rates"],
    numOfGusts: json["guests"],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": tripId,
      "name": name,
      "price": price,
      "images": images,
      "time": tripTime,
      "Facilities": facilities,
      "comfort_Facilities": comfortFacilities,
      "description": description,
      "location": location,
      "rating_count": ratingCount,
      "rates": rating,
      "guests": numOfGusts,
    };
  }
}

class TripModel {
  final String id;
  final Map<String, String> name;
  final Map<String, String> location;
  final Map<String, String> description;
  final List<String> images;
  final String time;
  final int guests;
  final String rates;
  final int ratingCount;
  final Map<String, dynamic> facilities;
  final List<String> comfortFacilities;

  TripModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.time,
    required this.guests,
    required this.rates,
    required this.ratingCount,
    required this.facilities,
    required this.comfortFacilities,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json["id"],
      name: json["name"] != null ? Map<String, String>.from(json["name"].map((k, v) => MapEntry(k, v.toString()))) : {},
      location: json["location"] != null ? Map<String, String>.from(json["location"].map((k, v) => MapEntry(k, v.toString()))) : {},
      description: json["description"] != null ? Map<String, String>.from(json["description"].map((k, v) => MapEntry(k, v.toString()))) : {},
      images: json["images"] != null ? List<String>.from(json["images"].map((v) => v.toString())) : [],
      time: json["time"],
      guests: json["guests"],
      rates: json["rates"],
      ratingCount: json["rating_count"],
      facilities: Map<String, dynamic>.from(json["Facilities"] ?? {}),
      comfortFacilities: json["comfort_Facilities"] != null ? List<String>.from(json["comfort_Facilities"].map((v) => v.toString())) : [],
    );
  }  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "location": location,
      "description": description,
      "images": images,
      "time": time,
      "guests": guests,
      "rates": rates,
      "rating_count": ratingCount,
      "Facilities": facilities,
      "comfort_Facilities": comfortFacilities,
    };
  }
}
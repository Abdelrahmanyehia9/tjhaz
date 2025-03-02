class ReservationModel {
  final List<int>? reservedDates;
  final Map<String, List<int>> ? reservedHours;

  ReservationModel({ this.reservedDates,  this.reservedHours});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      reservedDates: List<int>.from(json["reserved_days"] ?? []),
      reservedHours: (json["reserved_hours"] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(key, List<int>.from(value))) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reserved_days": reservedDates,
      "reserved_hours": reservedHours?.map((key, value) => MapEntry(key, value)),
    };
  }
}

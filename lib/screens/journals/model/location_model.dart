class LocationModel {
  String? address;
  double? lat;
  double? lng;

  LocationModel({this.address, this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        address: json["locationText"],
        lat: json["latitude"],
        lng: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "locationText": address,
        "latitude": lat,
        "longitude": lng,
      };
}

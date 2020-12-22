class Location {
  int locationID;
  String line1;
  String line2;
  String district;
  String city;
  String state;
  double latitude;
  double longitude;

  Location(
      {this.locationID,
      this.line1,
      this.line2,
      this.district,
      this.city,
      this.state,
      this.latitude,
      this.longitude});

  Location.fromJson(dynamic json) {
    locationID = json["locationID"];
    line1 = json["line1"];
    line2 = json["line2"];
    district = json['district'];
    city = json["city"];
    state = json["state"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  Map<String, dynamic> toJson(Location entry) {
    var map = <String, dynamic>{};
    map["locationID"] = entry.locationID;
    map["line1"] = entry.line1;
    map["line2"] = entry.line2;
    map["district"] = entry.district;
    map["city"] = entry.city;
    map["state"] = entry.state;
    map["latitude"] = entry.latitude;
    map["longitude"] = entry.longitude;
    return map;
  }
}

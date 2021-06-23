class Location {
  String uname;
  String latitude;
  String longitude;

  Location(this.uname, this.latitude, this.longitude);

  factory Location.fromJson(dynamic json) {
    return Location(
      json['uname'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
    );
  }
}

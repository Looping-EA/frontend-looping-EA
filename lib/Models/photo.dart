class Photo {
  String imagePath;

  Photo(this.imagePath);

  factory Photo.fromJson(dynamic json) {
    return Photo(json['imagePath'] as String);
  }
}

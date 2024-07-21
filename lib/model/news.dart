class News {
  int? locationID;
  String? title;
  String? description;
  String? timeUpload;

  News({
    this.locationID,
    this.title,
    this.description,
    this.timeUpload,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      locationID: json['locationID'],
      title: json['title'],
      description: json['description'],
      timeUpload: json['timeUpload'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationID': locationID,
      'title': title,
      'description': description,
      'timeUpload': timeUpload,
    };
  }
}

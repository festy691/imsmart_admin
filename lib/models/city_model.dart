class CityModel {
  final id;
  final title;
  final description;
  final displayImage;
  final isAvailable;
  final date;

  CityModel(
      {this.id,
      this.title,
      this.description,
      this.displayImage,
      this.isAvailable,
      this.date});

  factory CityModel.fromJson(Map<String, dynamic> data){
    return CityModel(
      id: data["_id"],
      title: data["title"],
      description: data["description"],
      displayImage: data["displayImage"],
      isAvailable: data["isAvailable"],
      date: data["date"],
    );
  }
}
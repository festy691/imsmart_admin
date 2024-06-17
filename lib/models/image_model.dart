class ImageModel{
  var id;
  var image;

  ImageModel({this.id, this.image});

  factory ImageModel.fromJson(Map<String, dynamic> data){
    return ImageModel(
      id: data['_id'],
      image: data['image'],
    );
  }

}
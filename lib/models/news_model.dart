class NewsModel {
  final id;
  final title;
  final message;
  final date;
  final images;

  NewsModel({this.id, this.title, this.message, this.date, this.images});

  factory NewsModel.fromJson(Map<String, dynamic> data){
    return NewsModel(
      id: data['_id'],
      title: data['title'],
      message: data['message'],
      date: data['date'],
      images: data['images'],
    );
  }
}
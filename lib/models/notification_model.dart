class NotificationModel {
  final id;
  final read;
  final title;
  final message;
  final date;

  NotificationModel({this.id, this.read, this.title, this.message, this.date});


  factory NotificationModel.fromJson(Map<String, dynamic> data){
    return NotificationModel(
      id: data['_id'],
      read: data['read'],
      title: data['title'],
      message: data['message'],
      date: data['date'],
    );
  }

}
import 'package:imsmart_admin/models/room_item_model.dart';
import 'package:imsmart_admin/models/room_section_model.dart';
import 'package:imsmart_admin/pages/home_screens/components/room_section.dart';

class RoomPropertyModel {
  final id;
  final roomNumber;
  final toilet;
  final title;
  final imagePath;
  final amount;
  final cautionFee;
  final status;
  final roomItems;
  final location;
  final description;
  final roomImages;
  final date;
  final totalRating;
  final city;
  final contact;

  RoomPropertyModel({
    this.id,
    this.roomNumber,
    this.title,
    this.imagePath,
    this.amount,
    this.cautionFee,
    this.toilet,
    this.status,
    this.roomItems,
    this.location,
    this.description,
    this.roomImages,
    this.date,
    this.totalRating,
    this.city,
    this.contact,
  });

  factory RoomPropertyModel.fromJson(Map<String, dynamic> data) {
    return RoomPropertyModel(
      id: data["_id"],
      title: data["title"],
      roomNumber: data["bedroom"] ?? 1,
      toilet: data["toilet"] ?? 1,
      imagePath: data["displayImage"],
      amount: data["costAmount"],
      cautionFee: data["cautionFee"] ?? 0,
      status: data["isAvailable"] ?? true,
      roomItems: data["amenities"] ?? [],
      location: data["address"],
      description: data["description"],
      roomImages: data["imageList"],
      date: data["date"],
      totalRating: data["totalRating"],
      city: data["city"],
      contact: data["contact"],
    );
  }

  toJson(){
    return {
      "title": title,
      "description": description,
      "costAmount": amount,
      "cautionFee": cautionFee,
      "address": location,
      "amenities": roomItems,
    };
  }
}

import 'package:imsmart_admin/pages/home_screens/components/room_section.dart';

class RoomSectionModel {
  final String imagePath;
  final String? roomSection;
  final String? ratings;

  RoomSectionModel({
    required this.imagePath,
    this.roomSection,
    this.ratings,
  });
}

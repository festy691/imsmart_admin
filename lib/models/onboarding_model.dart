class OnBoardingModel {
  final String imageAssetPath;
  final String title;
  final String heading;
  final String headingContd;
  final String caption;

  const OnBoardingModel(
      {required this.imageAssetPath,
      required this.title,
      required this.heading,
      required this.headingContd,
      required this.caption});

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) {
    return OnBoardingModel(
      imageAssetPath: json["imageAssetPath"],
      title: json["title"],
      heading: json["heading"],
      headingContd: json["headingContd"],
      caption: json["caption"],
    );
  }

  @override
  String toString() {
    return "ImageAssetPath => $imageAssetPath, title => $title, heading => $heading, headingContd => $headingContd, caption => $caption";
  }

  @override
  bool operator ==(covariant OnBoardingModel other) =>
      other.imageAssetPath == imageAssetPath &&
      other.title == title &&
      other.heading == heading &&
      other.headingContd == headingContd &&
      other.caption == caption;

  @override
  int get hashCode =>
      imageAssetPath.hashCode ^
      title.hashCode ^
      heading.hashCode ^
      headingContd.hashCode ^
      caption.hashCode;
}

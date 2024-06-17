class ReferralModel {
  final id;
  final name;
  final code;
  final discount;

  ReferralModel({this.id, this.name, this.code, this.discount});

  factory ReferralModel.fromJson(Map<String, dynamic> data){
    return ReferralModel(
      id: data["_id"],
      name: data["name"],
      code: data["code"],
      discount: data["discount"],
    );
  }
}
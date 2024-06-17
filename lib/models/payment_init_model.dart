class PaymentInitModel {
  final authUrl;
  final accessCode;
  final reference;

  PaymentInitModel({this.authUrl, this.accessCode, this.reference});

  factory PaymentInitModel.fromJson(Map<String, dynamic> data){
    return PaymentInitModel(
      authUrl: data["authorization_url"],
      accessCode: data["access_code"],
      reference: data["reference"],
    );
  }
}
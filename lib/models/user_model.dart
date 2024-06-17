class UserModel {
  final id;
  final name;
  final email;
  final phonenumber;
  final referralCode;
  final password;
  final accountName;
  final hasSubmittedID;
  final kyc;
  final bankName;
  final accountNumber;
  final walletBalance;
  final referralBalance;
  final lastTrade;
  final image;
  final transactionPin;
  bool enableTwoFactor;
  bool activated;
  final firebaseToken;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phonenumber,
      this.password,
      this.accountName,
      this.bankName,
      this.accountNumber,
      this.image,
      this.walletBalance,
      this.referralBalance,
      this.hasSubmittedID,
      this.kyc,
      this.lastTrade,
      this.transactionPin,
      this.referralCode,
      this.firebaseToken,
      this.activated = false,
      this.enableTwoFactor = false});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['_id'] ?? "",
      image: data['image'] ?? "",
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      phonenumber: data['phonenumber'] ?? "",
      referralCode: data['referralCode'] ?? data['phonenumber'] ?? '',
      walletBalance: data['walletBalance'] ?? 0,
      referralBalance: data['referralBalance'] ?? 0,
      accountName: data['accountName'] ?? "",
      lastTrade: data['lastTrade'] ?? 0,
      hasSubmittedID: data['hasSubmittedID'] ?? false,
      activated: data['activated'] ?? false,
      kyc: data['kyc'] ?? "",
      bankName: data['bankName'] ?? "",
      transactionPin: data['transactionPin'] ?? "",
      accountNumber: data['accountNumber'] ?? "",
      firebaseToken: data['firebaseToken'] ?? "",
      enableTwoFactor: data['enableTwoFactorCode'] ?? false,
    );
  }

  toJson() {
    return {
      "name": name,
      "email": email,
      "phonenumber": phonenumber,
      "bankName": bankName,
      "accountName": accountName,
      "accountNumber": accountNumber,
      "firebaseToken": firebaseToken,
      "referralCode": referralCode,
      "password": password,
    };
  }
}

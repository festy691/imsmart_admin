class BookApartmentModel {
  var firstName;
  var lastName;
  var address;
  var email;
  var checkinDate;
  var checkoutDate;
  var country;
  var phoneNumber;
  var transactionAmount;
  var discountAmount;
  var transactionRef;
  var property;
  var receipt;
  var isTransfer;
  var referralCode;

  BookApartmentModel(
      {this.firstName,
      this.lastName,
      this.address,
      this.email,
      this.checkinDate,
      this.checkoutDate,
      this.country,
      this.phoneNumber,
      this.transactionAmount,
      this.discountAmount,
      this.transactionRef,
      this.property,
      this.receipt,
      this.referralCode,
      this.isTransfer});

  factory BookApartmentModel.fromJson(Map<String, dynamic> data) {
    return BookApartmentModel(
      checkinDate: data["checkinDate"],
      checkoutDate: data["checkoutDate"],
    );
  }

  toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "email": email,
      "checkinDate": checkinDate,
      "checkoutDate": checkoutDate,
      "country": country,
      "phoneNumber": phoneNumber,
      "transactionAmount": transactionAmount,
      "transactionRef": transactionRef,
      "property": property,
      "receipt": receipt,
      "isTransfer": isTransfer,
      "referralCode": referralCode,
    };
  }
}

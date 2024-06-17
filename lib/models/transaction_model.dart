class TransactionModel{
  final id;
  final firstName;
  final lastName;
  final email;
  final address;
  final phoneNumber;
  final checkinDate;
  final checkoutDate;
  final country;
  final transactionAmount;
  final transactionRef;
  final status;
  final property;
  final date;

  TransactionModel(
      {
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.phoneNumber,
      this.checkinDate,
      this.checkoutDate,
      this.country,
      this.transactionAmount,
      this.transactionRef,
      this.status,
      this.property,
      this.date});

  factory TransactionModel.fromJson(Map<String, dynamic> data){
    return TransactionModel(
      id: data['_id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      country: data['country'],
      transactionAmount: data['transactionAmount'],
      checkinDate: data['checkinDate'],
      checkoutDate: data['checkoutDate'],
      transactionRef: data['transactionRef'],
      status: data['status'],
      property: data['property'],
      date: data['date'],
    );
  }
}
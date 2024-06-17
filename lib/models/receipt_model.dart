class ReceiptModel {
  var sender;
  var receiver;
  var accountNumber;
  var fromMe;
  var date;
  var amount;
  var id;
  var type;
  var status;

  ReceiptModel(
      {this.sender,
      this.receiver,
      this.accountNumber,
      this.fromMe = true,
      this.date,
      this.amount,
      this.id,
      this.type,
      this.status});
}
import 'package:cloud_firestore/cloud_firestore.dart';

class IntransactionModel {
  String id;
  String cargoid;
  dynamic receipt;
  dynamic amount;
  dynamic date;
  String account;

  IntransactionModel({
    this.cargoid,
    this.id,
    this.receipt,
    this.amount,
    this.date,
    this.account,
  });
  factory IntransactionModel.fromDoc(DocumentSnapshot json) {
    return IntransactionModel(
      id: json.id,
      cargoid: json['cargoid'],
      receipt: json['Receipt'],
      amount: json['Amount'],
      date: json['Timestamp'],
      account: json['account'],
    );
  }
}

class TransactionModel {
  String phoneNumber;
  String agentNumber;
  bool verified;
  String name;
  String method;
  String id;
  String cargoid;
  dynamic transactioncode;
  dynamic amount;
  dynamic date;
  String account;

  TransactionModel({
    this.phoneNumber,
    this.agentNumber,
    this.verified,
    this.name,
    this.method,
    this.cargoid,
    this.id,
    this.transactioncode,
    this.amount,
    this.date,
    this.account,
  });
  factory TransactionModel.fromDoc(DocumentSnapshot json) {
    return TransactionModel(
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      agentNumber: json['agentNumber'],
      verified: json['verified'],
      method: json['method'],
      id: json.id,
      cargoid: json['cargoid'],
      transactioncode: json['transactioncode'],
      amount: json['amount'],
      date: json['date'],
      account: json['account'],
    );
  }
}

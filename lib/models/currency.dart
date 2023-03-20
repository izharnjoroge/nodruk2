import 'package:cloud_firestore/cloud_firestore.dart';

class CurrencyModel {
  String id;
  String name;

  CurrencyModel({
    this.id,
    this.name,
  });
  factory CurrencyModel.fromDoc(DocumentSnapshot json) {
    return CurrencyModel(
      id: json.id,
      name: json['name'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class IdentifierModel {
  String id;
  String name;

  IdentifierModel({
    this.id,
    this.name,
  });
  factory IdentifierModel.fromDoc(DocumentSnapshot json) {
    return IdentifierModel(
      id: json.id,
      name: json['name'],
    );
  }
}

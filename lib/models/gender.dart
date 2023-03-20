import 'package:cloud_firestore/cloud_firestore.dart';

class GenderModel {
  String id;
  String name;

  GenderModel({
    this.id,
    this.name,
  });
  factory GenderModel.fromDoc(DocumentSnapshot json) {
    return GenderModel(
      id: json.id,
      name: json['name'],
    );
  }
}

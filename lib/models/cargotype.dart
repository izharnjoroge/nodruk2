import 'package:cloud_firestore/cloud_firestore.dart';

class CargoType {
  String id;
  String name;

  CargoType({
    this.id,
    this.name,
  });
  factory CargoType.fromDoc(DocumentSnapshot json) {
    return CargoType(
      id: json.id,
      name: json['name'],
    );
  }
}

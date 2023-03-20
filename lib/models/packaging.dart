import 'package:cloud_firestore/cloud_firestore.dart';

class Packaging {
  String id;
  String name;

  Packaging({
    this.id,
    this.name,
  });
  factory Packaging.fromDoc(DocumentSnapshot json) {
    return Packaging(
      id: json.id,
      name: json['name'],
    );
  }
}

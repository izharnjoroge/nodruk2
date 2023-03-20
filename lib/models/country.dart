import 'package:cloud_firestore/cloud_firestore.dart';

class CountryModel {
  String id;
  String name;
  

  CountryModel({
    this.id,
    this.name,
  });
  factory CountryModel.fromDoc(DocumentSnapshot json) {
    return CountryModel(
      id: json.id,
      name: json['name'],
    );
  }
}


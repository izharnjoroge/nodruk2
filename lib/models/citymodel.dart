import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  String id;
  String country;
  String city;

  CityModel({
    this.id,
    this.country,
    this.city,
  });
  factory CityModel.fromDoc(DocumentSnapshot json) {
    return CityModel(
      id: json.id,
      city: json['city'],
      country: json['country'],
    );
  }
}

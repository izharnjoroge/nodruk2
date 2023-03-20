import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionModel {
  dynamic id;
  dynamic transporterid;
  dynamic cargoid;
  dynamic timestamp;
  dynamic status;

  dynamic cargoname;
  dynamic focountry;
  dynamic focity;
  dynamic fdcountry;
  dynamic fdcity;
  CollectionModel({
    this.id,
    this.transporterid,
    this.cargoname,
    this.fdcountry,
    this.fdcity,
    this.focountry,
    this.focity,
    this.cargoid,
    this.status,
    this.timestamp,
  });
  factory CollectionModel.fromDoc(DocumentSnapshot doc) {
    return CollectionModel(
      id: doc.id,
      transporterid: doc['transporterid'],
      cargoid: doc['cargoid'],
      status: doc['status'],
      timestamp: doc['date'],
      cargoname: doc["cargoname"],
      focountry: doc["focountry"],
      focity: doc["focity"],
      fdcountry: doc["fdcountry"],
      fdcity: doc["fdcity"],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:transporter/models/models.dart';

class CargoModel {
  CargoModel(
      {this.id,
      this.cargotype,
      this.packagetype,
      this.gweight,
      this.cargoname,
      this.fdcountry,
      this.fdcity,
      this.focountry,
      this.focity,
      this.requestcost,
      this.dopickup,
      this.status,
      this.owner,
      this.rate,
      this.currency,
      // this.collectiondata,
      this.adinfo});

  dynamic id;
  dynamic cargotype;
  dynamic packagetype;
  dynamic gweight;
  dynamic status;
  dynamic owner;
  dynamic requestcost;
  dynamic adinfo;
  dynamic cargoname;
  dynamic focountry;
  dynamic focity;
  dynamic fdcountry;
  dynamic fdcity;
  dynamic dopickup;
  dynamic rate;
  dynamic currency;
  // List collectiondata;
  factory CargoModel.fromDoc(DocumentSnapshot doc) {
    return CargoModel(
        id: doc.id,
        cargotype: doc["cargotype"],
        // collectiondata: doc["collectiondata"],
        packagetype: doc["packagetype"],
        requestcost: doc["requestcost"],
        status: doc["status"],
        owner: doc["owner"],
        gweight: doc["gweight"],
        cargoname: doc["cargoname"],
        focountry: doc["focountry"],
        focity: doc["focity"],
        fdcountry: doc["fdcountry"],
        fdcity: doc["fdcity"],
        dopickup: doc["dopickup"],
        currency: doc["currency"],
        rate: doc["rate"],
        adinfo: doc['adinfo']);
  }
}

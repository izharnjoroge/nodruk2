import 'package:transporter/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final countryref = _firestore.collection('countries');
final truckownersref = _firestore.collection('truckowners');
final userref = _firestore.collection('cargoownwers');
final cargotyperef = _firestore.collection('cargotype');
final packagingref = _firestore.collection('packaging');
final citiesref = _firestore.collection('cities');
final currencyref = _firestore.collection('transportercurrency');
final cargoref = _firestore.collection('cargo');
final cargocollectiondataref = _firestore.collection('cargocollectiondata');
final notificationref = _firestore.collection('notifications');
final depositsref = _firestore.collection('deposits');
final usagesref = _firestore.collection('usages');
final globaldataref = _firestore.collection('globaldata');

class Dbservice {
  static Future<UserModel> getcargoownerwithid(String id) async {
    DocumentSnapshot userDocSnapshot = await userref.doc(id).get();

    if (userDocSnapshot.exists) {
      return UserModel.fromDoc(userDocSnapshot);
    }
    return UserModel();
  }

  static Future<List<IntransactionModel>> getdeposits() async {
    QuerySnapshot dataSnapshot = await depositsref.get();

    List<IntransactionModel> countries = dataSnapshot.docs
        .map((doc) => IntransactionModel.fromDoc(doc))
        .toList();
    return countries;
  }

  static Future<List<TransactionModel>> getusages() async {
    QuerySnapshot dataSnapshot = await usagesref.get();
    List<TransactionModel> countries =
        dataSnapshot.docs.map((doc) => TransactionModel.fromDoc(doc)).toList();
    return countries;
  }

  static Future<List<CargoModel>> getallcargo() async {
    QuerySnapshot dataSnapshot = await cargoref.get();

    List<CargoModel> countries =
        dataSnapshot.docs.map((doc) => CargoModel.fromDoc(doc)).toList();
    return countries;
  }

  static Future<CargoModel> getallcargoid(String id) async {
    DocumentSnapshot userDocSnapshot = await cargoref.doc(id).get();

    if (userDocSnapshot.exists) {
      return CargoModel.fromDoc(userDocSnapshot);
    }
    return CargoModel();
  }

  static Future<List<CountryModel>> getCountries() async {
    QuerySnapshot dataSnapshot = await countryref.get();

    List<CountryModel> countries =
        dataSnapshot.docs.map((doc) => CountryModel.fromDoc(doc)).toList();
    return countries;
  }

  static Future<List<CurrencyModel>> getCurrency() async {
    QuerySnapshot dataSnapshot = await currencyref.get();

    List<CurrencyModel> countries =
        dataSnapshot.docs.map((doc) => CurrencyModel.fromDoc(doc)).toList();
    return countries;
  }

  static Future<List<CityModel>> getCities() async {
    QuerySnapshot dataSnapshot = await citiesref.get();

    List<CityModel> countries =
        dataSnapshot.docs.map((doc) => CityModel.fromDoc(doc)).toList();

    return countries;
  }

  static Future<List<CargoType>> getCargotype() async {
    QuerySnapshot dataSnapshot = await cargotyperef.get();

    List<CargoType> countries =
        dataSnapshot.docs.map((doc) => CargoType.fromDoc(doc)).toList();
    return countries;
  }

  static Future<List<Packaging>> getPackagings() async {
    QuerySnapshot dataSnapshot = await packagingref.get();

    List<Packaging> countries =
        dataSnapshot.docs.map((doc) => Packaging.fromDoc(doc)).toList();
    return countries;
  }

  static Future<List<GlobalData>> getGlobalData() async {
    QuerySnapshot dataSnapshot = await globaldataref.get();

    List<GlobalData> countries =
        dataSnapshot.docs.map((doc) => GlobalData.fromDoc(doc)).toList();
    return countries;
  }

  static Future<UserModel> getuserwithid(String id) async {
    DocumentSnapshot userDocSnapshot = await truckownersref.doc(id).get();

    if (userDocSnapshot.exists) {
      return UserModel.fromDoc(userDocSnapshot);
    }
    return UserModel();
  }
}

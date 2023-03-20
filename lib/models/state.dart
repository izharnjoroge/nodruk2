import 'package:firebase_auth/firebase_auth.dart';
import 'package:transporter/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/dbservices.dart';

class AppState extends ChangeNotifier {
  String userid;
  SharedPreferences prefs;
  DateTime selecteddate;
  CountryModel country;
  CountryModel icountry;
  CountryModel focountry;
  CityModel focity;
  CityModel fdcity;
  CountryModel fdcountry;
  GenderModel sgender;
  int selectedIndex = 0;
  IdentifierModel sidentifier;
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<CargoType> cargoTypes = [];
  CargoType cargoType;
  List<Packaging> packagings = [];
  List<CurrencyModel> currencies = [];
  List<GlobalData> globalData = [];
  CurrencyModel currency;
  Packaging packaging;
  String socity = '';
  String sdcity = '';
  String phonenocode = '+254';
  String altphonenocode = '+254';
  UserModel userModel;
  List<GenderModel> gender = [
    GenderModel(name: "Male", id: "1"),
    GenderModel(name: "Female", id: "2"),
  ];
  List<IdentifierModel> identifier = [
    IdentifierModel(name: "ID Number", id: "1"),
    IdentifierModel(name: "Passport Number", id: "2"),
  ];
  List<IntransactionModel> deposits = [];
  List<TransactionModel> usages = [];
  AppState() {
    getIToken();
    sidentifier = identifier[0];
  }

  void getIToken() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      setUpApp();
      if (user == null) {
      } else {
        setUpwallet(user.uid);
      }
    });
  }

  setUpwallet(id) async {
    await Dbservice.getuserwithid(id).then((uvalue) async {
      userModel = uvalue;
      deposits.clear();
      usages.clear();
      await Dbservice.getdeposits().then((value) {
        deposits = value
            .where((v) =>
                v.account.toString().trim() == uvalue.indno.toString().trim())
            .toList();
      });
      await Dbservice.getusages().then((value) {
        usages = value
            .where((v) =>
                v.account.toString().trim() == uvalue.indno.toString().trim())
            .toList();
      });
    });
  }

  setUpApp() async {
    countries.clear();
    cities.clear();
    packagings.clear();
    currencies.clear();
    cargoTypes.clear();
    await Dbservice.getGlobalData().then((value) {
      globalData = [...globalData, ...value];
    });
    await Dbservice.getCountries().then((value) {
      countries = [...countries, ...value];
      icountry = countries[0];
      country = countries[0];
      selecteddate = DateTime.now();
      sgender = gender[0];
    });
    await Dbservice.getCities().then((value) {
      cities = [...cities, ...value];
    });
    await Dbservice.getCargotype().then((value) {
      cargoTypes = [...cargoTypes, ...value];
      cargoType = cargoTypes[0];
    });
    await Dbservice.getPackagings().then((value) {
      packagings = [...packagings, ...value];
      packaging = packagings[0];
    });
    await Dbservice.getCurrency().then((value) {
      currencies = [...currencies, ...value];
      currency = currencies[0];
    });
    notifyListeners();
  }

  void updateind(val) {
    sidentifier = val;
    notifyListeners();
  }

  void updatedocountry(val) {
    focountry = val;
    List<CityModel> fc;
    fc = cities.where((e) => e.country == val.id).toList();
    focity = fc.first;
    notifyListeners();
  }

  void updateddcountry(val) {
    List<CityModel> fc;
    fc = cities.where((e) => e.country == val.id).toList();
    fdcity = fc.first;
    notifyListeners();
  }
}

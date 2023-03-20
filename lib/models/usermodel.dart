import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(
      {this.id,
      this.names,
      this.email,
      this.phoneno,
      this.altphoneno,
      this.password,
      this.indno,
      this.indentifier,
      this.coissue,
      this.coorigin,
      this.expdate,
      this.gender});

  String id;
  String names;
  String email;
  String phoneno;
  String altphoneno;
  String password;
  String gender;
  String indentifier;
  String indno;
  String coissue;
  dynamic expdate;
  String coorigin;
  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
        id: doc.id,
        names: doc["names"],
        expdate: doc["expdate"] ?? '',
        email: doc["email"],
        phoneno: doc["phoneno"],
        altphoneno: doc["altphoneno"],
        indentifier: doc["indentifier"],
        indno: doc["indno"],
        coissue: doc["coissue"],
        coorigin: doc["coorigin"],
        gender: doc['gender']);
  }
}

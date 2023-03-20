import 'package:transporter/models/models.dart';
import 'package:transporter/models/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/componets.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future signUpUser(BuildContext context, UserModel user) async {
    try {
      _auth
          .createUserWithEmailAndPassword(
              email: user.email.trim(), password: user.password.trim())
          .then((value) {
        _firestore.collection('/truckowners').doc(value.user.uid).set({
          'altphoneno': user.altphoneno,
          'phoneno': user.phoneno,
          'password': "",
          'names': user.names,
          'indno': user.indno,
          'email': user.email,
          'gender': user.gender,
          'indentifier': user.indentifier,
          'coissue': user.coissue,
          'expdate': user.expdate,
          'coorigin': user.coorigin,
        });
        Provider.of<AppState>(context, listen: false).userid = value.user.uid;

        return value.user.uid;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Error';
      } else if (e.code == 'email-already-in-use') {
        return 'Error';
      }
    }
  }

  static logout(context) {
    _auth.signOut();
    SystemNavigator.pop();
  }

  static Future login(
      BuildContext context, String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Provider.of<AppState>(context, listen: false).userid = value.user.uid;
        return value.user.uid;
      });
    } on FirebaseAuthException {
      return "Error";
    }
  }

  static Future resetpassword(
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim()).then((value) {
        return "success";
      });
    } on FirebaseAuthException {
      return "Error";
    }
  }

  static Future changePassword(String email, String currentPassword,
      String newPassword, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    debugPrint(email.trim());
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: currentPassword.trim())
          .then((value) {
        try {
          user.updatePassword(newPassword).then((_) {
            debugPrint("Successfully changed password");
            MyNavigator.goToLogin(context);
            _auth.signOut();
            return 'success';
          }).catchError((error) {
            debugPrint("Password can't be changed" + error.toString());
            return 'error';
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            debugPrint('No user found for that email.');
            return 'error';
          } else if (e.code == 'wrong-password') {
            debugPrint('Wrong password provided for that user.');
            return 'error';
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      return "Error";
    }
  }
}

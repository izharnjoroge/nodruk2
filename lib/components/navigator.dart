import 'package:transporter/screens/screens.dart';
import 'package:flutter/material.dart';

import '../models/country.dart';
// import '../models/state.dart';

class MyNavigator {
  static goToHomePage(BuildContext context, String uid) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return MainPage(
        uid: uid,
      );
    }));
  }

  static goToSignUp(BuildContext context, List<CountryModel> countries) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return SignUp(
        countries: countries,
      );
    }));
  }

  static goToLogin(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const Login();
    }));
  }

  static goToSplash(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const SplashTwo();
    }));
  }
}

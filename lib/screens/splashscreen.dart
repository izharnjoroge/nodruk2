import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/state.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SharedPreferences prefs;
  @override
  void initState() {
    getToken();
    super.initState();
  } 

  void getToken() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        MyNavigator.goToSplash(context);
      } else {
        Provider.of<AppState>(context, listen: false).setUpwallet(user.uid);
        setState(() {
          Provider.of<AppState>(context, listen: false).userid = user.uid;
        });
        MyNavigator.goToHomePage(context, user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .3,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: const Center(
              child: Image(
                image: CachedNetworkImageProvider(nodruklogo),
                height: 200.0,
                width: 200.0,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .3,
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:provider/provider.dart';
import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
// import 'package:transporter/models/state.dart';
// import 'package:transporter/models/state.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/dbservices.dart';

class SplashTwo extends StatefulWidget {
  const SplashTwo({Key key}) : super(key: key);

  @override
  _SplashTwoState createState() => _SplashTwoState();
}

class _SplashTwoState extends State<SplashTwo> {
  List<CountryModel> countries = [];
  @override
  void initState() {
    super.initState();
    Dbservice.getCountries().then((value) {
      countries = [...countries, ...value];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appstate = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: backgroundcolor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .05,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(nodruklogo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .25,
              child: Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        // color: Color(0xffffffff),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(spalsh1),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: Column(
                children: [
                  Text(
                    "SAFARI - Africa's First Cross Border Cargo Board",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: fontcolor,
                          fontSize: fontsize2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Enjoy Fast and Convenient\n Access to Cargo for Your Truck.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                          color: fontcolor,
                          fontSize: fontsize2,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      MyNavigator.goToSignUp(context, countries);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: maincolor,
                      ),
                      child: Center(
                        child: Text(
                          "SIGN UP",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: backgroundcolor,
                                fontSize: fontsize3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // otherstart(appstate);
                      MyNavigator.goToLogin(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(width: 1.0, color: maincolor),
                      ),
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: maincolor,
                                fontSize: fontsize3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/screens/findcargo.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/componets.dart';
import '../models/state.dart';
import 'screens.dart';

class Home extends StatefulWidget {
  final UserModel userModel;

  const Home({Key key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  void gotofindcargo(AppState appState) {
    // appState.setUp();
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return FindCargo(
        userModel: widget.userModel,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(padding + 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Hello ${widget.userModel == null ? '' : widget.userModel.names}!",
                              style: GoogleFonts.nunitoSans(
                                textStyle: const TextStyle(
                                    fontSize: fontsizel - 7,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Where would you like to transport cargo \ntoday?",
                              style: GoogleFonts.nunitoSans(
                                textStyle: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: fontsize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: userprofile,
                          fit: BoxFit.fill,
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      gotofindcargo(appstate);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .17,
                      decoration: BoxDecoration(
                        color: maincolor2,
                        borderRadius: BorderRadius.circular(5.00),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Find the best cargo deals across\n Africa",
                                style: GoogleFonts.nunitoSans(
                                  textStyle: const TextStyle(
                                      fontSize: fontsize1 + 3,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "See Cargo ->",
                                style: GoogleFonts.nunitoSans(
                                  textStyle: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: fontsize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  crossAxisCount: 2,
                  children: [
                    HomeComponent(
                      imageurl: findcargo,
                      compname: "Find Cargo",
                      whattodo: () {
                        gotofindcargo(appstate);
                      },
                    ),
                    HomeComponent(
                      imageurl: wallet,
                      compname: "My Wallet",
                      whattodo: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Wallet(
                            userModel: widget.userModel,
                          );
                        }));
                      },
                    ),
                    HomeComponent(
                      imageurl: history,
                      compname: "My History",
                      whattodo: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return History(
                            userModel: widget.userModel,
                          );
                        }));
                      },
                    ),
                    HomeComponent(
                      imageurl: comingsoon,
                      compname: "Coming Soon",
                      whattodo: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const ComingSoon();
                        }));
                      },
                    ),
                    HomeComponent(
                      imageurl: comingsoon,
                      compname: "Coming Soon",
                      whattodo: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const ComingSoon();
                        }));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

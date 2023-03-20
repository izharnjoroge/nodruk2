import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../models/state.dart';
import '../theme/theme.dart';
import 'screens.dart';

class MainPage extends StatefulWidget {
  final String uid;

  const MainPage({Key key, this.uid}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  bool isLoading = false;

  @override
  void initState() {
    // setUser();
    super.initState();
  }

  // void setUser() {
  //   Dbservice.getuserwithid(widget.uid).then((value) => setState(() {
  //         user = value;
  //       }));
  //   // setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    List _widgetOptions = [
      Home(
        userModel: appstate.userModel,
      ),
      const HelpPage(),
      MainProfile(
        userModel: appstate.userModel,
      ),
      const LogOut(),
    ];

    return appstate.userModel == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SafeArea(
                child: _widgetOptions.elementAt(appstate.selectedIndex)),
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: GoogleFonts.nunitoSans(
                  textStyle: TextStyle(
                      color: maincolor,
                      fontSize: fontsize,
                      fontWeight: FontWeight.bold)),
              selectedItemColor: backgroundcolor,
              unselectedItemColor: fontcolor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedLabelStyle: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                      fontSize: fontsize, fontWeight: FontWeight.bold)),
              items: [
                BottomNavigationBarItem(
                  icon: appstate.selectedIndex == 0
                      ? const CustomIcon(
                          icon: Icon(
                            Ionicons.home,
                            size: 20,
                          ),
                          index: 0)
                      : const CustomIcon(
                          icon: Icon(
                            Ionicons.home_outline,
                            size: 20,
                          ),
                          index: 0),
                  label: 'MainPage',
                ),
                BottomNavigationBarItem(
                  icon: appstate.selectedIndex == 1
                      ? const CustomIcon(
                          icon: Icon(
                            Ionicons.help_circle,
                            size: 20,
                          ),
                          index: 1)
                      : const CustomIcon(
                          icon: Icon(
                            Ionicons.help_circle_outline,
                            size: 20,
                          ),
                          index: 1),
                  label: 'Help',
                ),
                BottomNavigationBarItem(
                  icon: appstate.selectedIndex == 2
                      ? const CustomIcon(
                          icon: Icon(
                            Ionicons.person,
                            size: 20,
                          ),
                          index: 2)
                      : const CustomIcon(
                          icon: Icon(
                            Ionicons.person_outline,
                            size: 20,
                          ),
                          index: 2),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: appstate.selectedIndex == 3
                      ? const CustomIcon(
                          icon: Icon(
                            Ionicons.log_out,
                            size: 20,
                          ),
                          index: 2)
                      : const CustomIcon(
                          icon: Icon(
                            Ionicons.log_out_outline,
                            size: 20,
                          ),
                          index: 3),
                  label: 'Log Out',
                ),
              ],
              currentIndex: appstate.selectedIndex,
              onTap: (index) {
                setState(
                  () {
                    appstate.selectedIndex = index;
                  },
                );
              },
            ),
          );
  }
}

class CustomIcon extends StatelessWidget {
  final Widget icon;
  final int index;
  const CustomIcon({Key key, @required this.index, @required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Container(
      decoration: BoxDecoration(
        color: appstate.selectedIndex == index ? maincolor : backgroundcolor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            width: 1.0,
            color: appstate.selectedIndex == index ? maincolor : fontcolor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: icon,
      ),
    );
  }
}

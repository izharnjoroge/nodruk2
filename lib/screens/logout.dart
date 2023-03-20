import 'package:transporter/services/auth.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/data.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key key}) : super(key: key);

  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool loggededin = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  TextEditingController rateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            "Logout",
            style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: fontsize1,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Logout",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            fontSize: fontsize1, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Logging out of the platform would need \nyou to sign in again later.\nAre you sure you want to logout?",
                            style: GoogleFonts.nunitoSans(
                              textStyle: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: fontsize2,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    AuthService.logout(context);
                    // submit(context, appstate);
                  },
                  child: Container(
                    height: 45.00,
                    width: MediaQuery.of(context).size.width * .45,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(5.00),
                    ),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: backgroundcolor,
                              fontSize: fontsize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

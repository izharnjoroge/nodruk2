import 'package:firebase_auth/firebase_auth.dart';
import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/screens/screens.dart';
import 'package:transporter/services/services.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';

class Login extends StatefulWidget {
  final List<CountryModel> countries;

  const Login({Key key, this.countries}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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

  void submit(BuildContext context, AppState appState) async {
    final formField = formKey.currentState;

    if (formField.validate()) {
      formField.save();

      setState(() {
        isLoading = true;
      });
      AuthService.login(context, emailController.text, passController.text)
          .then((result) {
        if (result != 'Error') {
          Dbservice.getuserwithid(appState.userid).then((value) => setState(() {
                if (value.email == null) {
                  final _auth = FirebaseAuth.instance;
                  showInSnackBar("Invalid Logins");
                  _auth.signOut().then((value) {
                    MyNavigator.goToSplash(context);
                  });
                } else {
                  setState(() {
                    appState.userModel = value;
                    isLoading = false;
                  });
                  MyNavigator.goToHomePage(context, appState.userid);
                }
              }));
        } else {
          showInSnackBar('Error Occured');
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });

      showInSnackBar('Ooooh no! Bad Input!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          "Login",
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                color: Colors.black45,
                fontSize: fontsize1,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome back!",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            fontSize: fontsizel, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enter the details below to login to your account",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: fontsize3,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextInputComponent(
                        title: "Email Address",
                        titleController: emailController,
                        height: 50,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextInputComponent(
                        title: "Password",
                        titleController: passController,
                        height: 50,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 30),
                      loggededin
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                submit(context, appstate);
                              },
                              child: Container(
                                height: 45.00,
                                // width: MediaQuery.of(context).size.width * .9,
                                decoration: BoxDecoration(
                                  color: maincolor,
                                  borderRadius: BorderRadius.circular(5.00),
                                ),
                                child: Center(
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        )
                                      : Text(
                                          "LOGIN",
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
                      TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const ResetPass();
                            }));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Forgot your Password? ",
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          color: fontcolor,
                                          fontSize: fontsize3,
                                          fontWeight: FontWeight.bold))),
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {                         
                            MyNavigator.goToSignUp(
                                context, appstate.countries);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          color: fontcolor,
                                          fontSize: fontsize3,
                                          fontWeight: FontWeight.bold))),
                              Text("Sign up",
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          color: maincolor,
                                          fontSize: fontsize3,
                                          fontWeight: FontWeight.bold))),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

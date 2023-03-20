import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/services/services.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';

class SignUpTwo extends StatefulWidget {
  final String fullname;
  final String idno;

  const SignUpTwo({Key key, this.fullname, this.idno}) : super(key: key);

  @override
  _SignUpTwoState createState() => _SignUpTwoState();
}

class _SignUpTwoState extends State<SignUpTwo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController altphoneController = TextEditingController();
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

  bool validateEmail(email) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  void submit(BuildContext context, AppState appState) async {
    final formField = formKey.currentState;

    if (formField.validate()) {
      showInSnackBar('Signing Up ...');
      formField.save();
      setState(() {
        isLoading = true;
      });
      AuthService.signUpUser(
              context,
              UserModel(
                  phoneno: "${appState.phonenocode}${phoneController.text}",
                  altphoneno:
                      "${appState.altphonenocode}${altphoneController.text}",
                  password: passController.text,
                  names: widget.fullname,
                  indno: widget.idno,
                  email: emailController.text,
                  gender: appState.sgender.name,
                  indentifier: appState.sidentifier.name,
                  coissue:
                      appState.icountry == null ? '' : appState.icountry.name,
                  expdate: appState.selecteddate,
                  coorigin:
                      appState.country == null ? '' : appState.country.name))
          .then((result) {
        if (result != 'Error') {
          MyNavigator.goToHomePage(context, result);
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          showInSnackBar('Error Occured');
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
          "Sign Up",
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
                      "Let's set up your account",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            fontSize: fontsizel, fontWeight: FontWeight.bold),
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
                      PhoneNumberInputComponent(
                        title: "Phone Number",
                        titleController: phoneController,
                        keyboardType: TextInputType.phone,
                        height: 50,
                      ),
                      PhoneNumberInputComponent(
                        title: "Alternative Phone Number",
                        titleController: altphoneController,
                        keyboardType: TextInputType.phone,
                        height: 50,
                      ),
                      TextInputComponent(
                        title: "Email Address",
                        titleController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        height: 50,
                      ),
                      TextInputComponent(
                        title: "Create Password",
                        titleController: passController,
                        keyboardType: TextInputType.text,
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "By signing up you're agree to our ",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    fontSize: fontsize3,
                                    color: fontcolor2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Terms and Conditions",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    fontSize: fontsize3,
                                    color: maincolor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      loggededin
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () => submit(context, appstate),
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
                                          "GET STARTED",
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
                            MyNavigator.goToLogin(context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                  style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          color: fontcolor,
                                          fontSize: fontsize3,
                                          fontWeight: FontWeight.bold))),
                              Text("Sign In",
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

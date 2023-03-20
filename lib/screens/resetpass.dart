import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/services/services.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({
    Key key,
  }) : super(key: key);

  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool loggededin = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String error = '';
  void showInSnackBar(String txt) {
    setState(() {
      error = txt.toString();
    });
    // Toast.show(txt.toString(), gravity: Toast.center);
  }

  void submit(BuildContext context, AppState appState) async {
    final formField = formKey.currentState;

    if (formField.validate()) {
      formField.save();

      setState(() {
        isLoading = true;
      });
      AuthService.resetpassword(
        emailController.text,
      ).then((result) {
        if (result != 'Error') {
          showInSnackBar("Email Sent(check also spam)");
          setState(() {
            isLoading = false;
          });
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
          "Reset Password",
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
                      "Enter the details below to Reset Password of your account",
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
                      const SizedBox(height: 30),
                      error != ''
                          ? Container(
                              height: 45.00,
                              // width: 70,
                              decoration: BoxDecoration(
                                color: error == 'Error Occured(Try again)'
                                    ? maincolor
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(5.00),
                              ),
                              child: Center(
                                  child: Text(
                                error,
                                style: GoogleFonts.nunitoSans(
                                  textStyle: TextStyle(
                                      color: backgroundcolor,
                                      fontSize: fontsize,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 20,
                      ),
                      loggededin
                          ? const SizedBox.shrink()
                          : isLoading
                              ? Container(
                                  height: 45.00,
                                  // width: 150,
                                  decoration: BoxDecoration(
                                    color: maincolor,
                                    borderRadius: BorderRadius.circular(5.00),
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )),
                                )
                              : TextButton(
                                  onPressed: () {
                                    submit(context, appstate);
                                  },
                                  child: SizedBox(
                                    height: 45.00,
                                    // decoration: BoxDecoration(
                                    //   color: maincolor,
                                    //   borderRadius: BorderRadius.circular(5.00),
                                    // ),
                                    child: Center(
                                      child: Text(
                                        "Reset Password",
                                        style: GoogleFonts.nunitoSans(
                                          textStyle: TextStyle(
                                              color: maincolor,
                                              fontSize: fontsize1,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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

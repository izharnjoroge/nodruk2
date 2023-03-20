import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/screens/screens.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';

class SignUp extends StatefulWidget {
  final List<CountryModel> countries;

  const SignUp({Key key, this.countries}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  // static otherstart(AppState appState) {
  //   appState.setUpApp();
  // }

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submit(BuildContext context) async {
    final formField = formKey.currentState;

    if (formField.validate()) {
      formField.save();

      setState(() {
        isLoading = true;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SignUpTwo(
            fullname: nameController.text, idno: idController.text);
      }));
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
                      "Welcome to Safari!",
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
                      "Enter the details below to get started",
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
                        title: "Full Name",
                        titleController: nameController,
                        height: 50,
                        keyboardType: TextInputType.name,
                      ),
                      SelectionController(
                        listdata: appstate.gender,
                        listItem: appstate.gender[0],
                        title: "Gender",
                      ),
                      SelectionController(
                        listdata: appstate.identifier,
                        listItem: appstate.sidentifier,
                        title: "Identifier",
                      ),
                      widget.countries.isEmpty
                          ? const SizedBox.shrink()
                          : SelectionController(
                              listdata: widget.countries,
                              listItem: widget.countries[0],
                              title: "Country of Issue",
                            ),
                      appstate.sidentifier.name == 'ID Number'
                          ? TextInputComponent(
                              title: "ID number",
                              titleController: idController,
                              height: 50,
                              keyboardType: TextInputType.number,
                            )
                          : TextInputComponent(
                              title: "Passport Number",
                              titleController: idController,
                              keyboardType: TextInputType.number,
                              height: 50,
                            ),
                      appstate.sidentifier.name == 'ID Number'
                          ? const SizedBox.shrink()
                          : const DateInputComponent(
                              title: "Passport Expiry Date",
                              height: 50,
                            ),
                      widget.countries.isEmpty
                          ? const SizedBox.shrink()
                          : SelectionController(
                              listdata: widget.countries,
                              listItem: widget.countries[0],
                              title: "Country of Origin",
                            ),
                      const SizedBox(height: 30),
                      loggededin
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                submit(context);
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
                                          "CONTINUE",
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

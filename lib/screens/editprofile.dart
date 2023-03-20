import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/services/services.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/state.dart';

class EditProfile extends StatefulWidget {
  final String title;
  final String field;
  final String initialvalue;
  final UserModel userModel;

  const EditProfile(
      {Key key, this.title, this.userModel, this.field, this.initialvalue})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool loggededin = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController ivController;
  @override
  void initState() {
    super.initState();
    ivController = TextEditingController(text: widget.initialvalue);
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
      userref
          .doc(widget.userModel.id)
          .update({widget.field: ivController.text}).then((value) {
        MyNavigator.goToHomePage(context, appState.userid);
        showInSnackBar("Updated");
      });
      setState(() {
        isLoading = true;
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
          "Edit Profile",
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
                      "Edit Profile!",
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
                      TextInputComponent(
                        title: widget.title,
                        titleController: ivController,
                        height: 50,
                        keyboardType: TextInputType.emailAddress,
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
                                          "Edit Profile",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

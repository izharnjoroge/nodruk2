import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:transporter/components/componets.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/screens/screens.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/data.dart';

class UserProfile extends StatefulWidget {
  final UserModel userModel;

  const UserProfile({Key key, this.userModel}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  String formatTimestamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Account Details ...",
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
                SmallProfileDetails(
                  title: "Name",
                  text: widget.userModel.names,
                  editable: false,
                ),
                SmallProfileDetails(
                  title: "Gender",
                  text: widget.userModel.gender,
                  editable: false,
                ),
                SmallProfileDetails(
                  title: widget.userModel.indentifier,
                  text: widget.userModel.indno,
                  editable: false,
                ),
                widget.userModel.indentifier == "ID Number"
                    ? const SizedBox.shrink()
                    : SmallProfileDetails(
                        title: "Pasport Expiry Date",
                        text: formatTimestamp(widget.userModel.expdate),
                        editable: false,
                      ),
                SmallProfileDetails(
                  title: "Country of Issue",
                  text: widget.userModel.coissue,
                  editable: false,
                ),
                SmallProfileDetails(
                  title: "Phone Number",
                  text: widget.userModel.phoneno,
                  editable: true,
                  edit: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return EditProfile(
                        title: "Phone Number",
                        userModel: widget.userModel,
                        field: "phoneno",
                        initialvalue: widget.userModel.phoneno,
                      );
                    }));
                  },
                ),
                SmallProfileDetails(
                  title: "Alternative Phone No",
                  text: widget.userModel.altphoneno,
                  editable: true,
                  edit: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return EditProfile(
                        title: "Alternative Phone No",
                        userModel: widget.userModel,
                        field: "altphoneno",
                        initialvalue: widget.userModel.altphoneno,
                      );
                    }));
                  },
                ),
                SmallProfileDetails(
                  title: "Email Address",
                  text: widget.userModel.email,
                  editable: false,
                  edit: () {},
                ),
                SmallProfileDetails(
                  title: "Password",
                  text: "*******",
                  editable: true,
                  edit: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return UpdatePass(
                          title: "Password",
                          userModel: widget.userModel,
                          field: "Password",
                          initialvalue: "");
                    }));
                    // _showMyDialog(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

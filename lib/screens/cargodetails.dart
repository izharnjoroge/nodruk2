import 'dart:convert';

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:transporter/components/componets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/screens/cargoHistoryDetails.dart';
import 'package:transporter/screens/screens.dart';
import 'package:transporter/services/dbservices.dart';
import 'package:transporter/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../data/data.dart';
import '../models/models.dart';
import '../services/module.dart';

class CargoDetails extends StatefulWidget {
  final CargoModel cargoDetails;
  final UserModel userModel;

  const CargoDetails({Key key, this.cargoDetails, @required this.userModel})
      : super(key: key);

  @override
  _CargoDetailsState createState() => _CargoDetailsState();
}

class _CargoDetailsState extends State<CargoDetails> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isCollected = false;
  bool isloadingCollected = false;
  bool isloading = false;
  dynamic currentdata;
  @override
  void initState() {
    super.initState();
    getAccount();
  }

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  addlist(list) {
    var t = 0;
    for (var i = 0, _len = list.length; i < _len; i++) {
      t += int.parse(list[i].amount.toString().split('.')[0]);
    }
    return t;
  }

  var cargoposturl = Uri.parse(
      'https://us-central1-nodruk-5af1f.cloudfunctions.net/getaccount');
  Future<void> getAccount() async {
    request(url: cargoposturl, data: {
      "params": {'account': widget.userModel.indno, 'currency': "KES"}
    }).then((value) {
      currentdata = jsonDecode(value);

      setState(() {
        isLoading = false;
      });
    }).catchError((error) => showInSnackBar("Failed to Add : $error"));
  }

  Future<void> submit(BuildContext context, AppState appState) async {
    setState(() {
      isLoading = true;
      isloadingCollected = true;
    });
    return usagesref.add({
      'cargoid': widget.cargoDetails.id,
      'phoneNumber': null,
      'agentNumber': null,
      'name': widget.userModel.names,
      'amount': widget.cargoDetails.requestcost,
      'transactioncode': appState.userid,
      'verified': false,
      'date': DateTime.now().toIso8601String(),
      'account': widget.userModel.indno,
      'method': 'cargoPurchase'
    }).then((value) {
      cargocollectiondataref.add({
        "transporterid": appState.userModel.id,
        "date": DateTime.now(),
        "cargoid": widget.cargoDetails.id,
        "status": "payments",
        'focountry': widget.cargoDetails.focountry,
        'focity': widget.cargoDetails.focity,
        'fdcountry': widget.cargoDetails.fdcountry,
        'fdcity': widget.cargoDetails.fdcity,
        'cargoname': widget.cargoDetails.cargoname,
      }).then((value) {
        showInSnackBar("Toped Up,check History...");
        setState(() {
          isloadingCollected = false;
          isLoading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return CargoHistoryDetails(
            cargoHistoryDetails: widget.cargoDetails.id,
            userModel: widget.userModel,
          );
        }));
        // MyNavigator.goToHomePage(context, appState.userid);
        appState.setUpwallet(appState.userid);
      }).catchError((error) => showInSnackBar("Failed to Update : $error"));
    }).catchError((error) => showInSnackBar("Failed to Add 2 : $error"));
  }

  void showIF() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 350.0,
          color: const Color(0xFF737373),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.warning_amber,
                          color: Colors.red,
                          size: 35,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Insufficient Funds",
                              style: GoogleFonts.nunitoSans(
                                textStyle: TextStyle(
                                    color: fontcolor,
                                    fontSize: fontsize1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "You have insufficient funds in your wallet to \ncomplete this transaction. Please load your \nwallet to complete transaction.",
                              textAlign: TextAlign.center,
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Wallet(
                          userModel: widget.userModel,
                        );
                      }));
                    },
                    child: Container(
                      height: 45.00,
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                        color: maincolor,
                        borderRadius: BorderRadius.circular(5.00),
                      ),
                      child: Center(
                        child: Text(
                          "LOAD WALLET",
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
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45.00,
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.00),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1.00,
                          color: const Color(0xff707070),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "CANCEL",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: fontcolor,
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  void showSubscriptionPayment(AppState appState) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 300.0,
          color: const Color(0xFF737373),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Please pay your subscription with USD ${widget.cargoDetails.requestcost}.00 to access the cargo. Paying later would delay access to the cargo.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black45,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  isloadingCollected
                      ? Container(
                          height: 45.00,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(5.00),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: backgroundcolor,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 45.00,
                            width: MediaQuery.of(context).size.width * .8,
                            decoration: BoxDecoration(
                              color: maincolor,
                              borderRadius: BorderRadius.circular(5.00),
                            ),
                            child: Center(
                              child: Text(
                                "CONFIRM",
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
              )),
        );
      },
    );
  }

  void showshowSubscriptionPaymentRequied(AppState appstate) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 350.0,
          color: const Color(0xFF737373),
          child: currentdata == null
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.warning_amber,
                              color: Colors.amber,
                              size: 35,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Subscription Payment Required ",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: fontcolor,
                                        fontSize: fontsize1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Please top-up your subscription with USD ${widget.cargoDetails.requestcost}.00 to access the cargo. Paying later would delay access to the cargo.",
                                  textAlign: TextAlign.center,
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
                          Navigator.pop(context);
                          if (widget.cargoDetails.requestcost >
                              int.parse(
                                  "${currentdata['balance'].toStringAsFixed(0)}")) {
                            showIF();
                          } else {
                            debugPrint(appstate.userModel.id);
                            submit(context, appstate);
                          }
                        },
                        child: Container(
                          height: 45.00,
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(5.00),
                          ),
                          child: Center(
                            child: Text(
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
                    ],
                  )),
        );
      },
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }

  void showCargoownerDetails(AppState appstate, UserModel cargoowner) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 300.0,
          color: const Color(0xFF737373),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Ionicons.person_circle_outline,
                          color: fontcolor2, size: 50),
                      title: Text(
                        cargoowner.names,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        cargoowner.phoneno,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                cargoowner.phoneno);
                          },
                          icon: const Icon(Icons.call)),
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Ionicons.person_circle_outline,
                          color: fontcolor2, size: 50),
                      title: Text(
                        cargoowner.names,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Text(
                        cargoowner.altphoneno,
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                              color: fontcolor,
                              fontSize: fontsize1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                cargoowner.altphoneno);
                          },
                          icon: const Icon(Icons.call)),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Cargo ${widget.cargoDetails.id}",
            style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: fontsize1,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Cargo Details",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                          fontSize: fontsize1, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SmallCargoText(
                title: "Cargo Type",
                text: widget.cargoDetails.cargotype,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Cargo Name",
                text: widget.cargoDetails.cargoname,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Package Type",
                text: widget.cargoDetails.packagetype,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Gross Weight",
                text: '${widget.cargoDetails.gweight} Tonnes',
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Description",
                text: widget.cargoDetails.adinfo,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Address Details",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                          fontSize: fontsize1, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SmallCargoText(
                title: "Freight Origin Country",
                text: widget.cargoDetails.focountry,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Freight Origin City",
                text: widget.cargoDetails.focity,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Date of Pick Up",
                text: DateFormat.yMMMMd()
                    .format(DateTime.parse(widget.cargoDetails.dopickup)),
                // text: widget.cargoDetails.dopickup.toString(),
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Freight Destination Country",
                text: '${widget.cargoDetails.fdcountry}',
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                  title: "Freight Destination City",
                  text: widget.cargoDetails.fdcity),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Payment Details",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                          fontSize: fontsize1, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SmallCargoText(
                title: "Currency",
                text: widget.cargoDetails.currency,
              ),
              const SizedBox(
                height: 10,
              ),
              SmallCargoText(
                title: "Rate",
                text: widget.cargoDetails.rate,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: appstate.usages
                        .where((e) => e.cargoid == widget.cargoDetails.id)
                        .isEmpty
                    ? currentdata == null
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : GestureDetector(
                            onTap: () {
                              showshowSubscriptionPaymentRequied(appstate);
                            },
                            child: Container(
                              height: 45.00,
                              // width: MediaQuery.of(context).size.width * .9,
                              decoration: BoxDecoration(
                                color: maincolor,
                                borderRadius: BorderRadius.circular(5.00),
                              ),
                              child: Center(
                                child: Text(
                                  "View Cargo Owner",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: backgroundcolor,
                                        fontSize: fontsize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                    : GestureDetector(
                        onTap: () {
                          Dbservice.getcargoownerwithid(
                                  widget.cargoDetails.owner)
                              .then((value) {
                            showCargoownerDetails(appstate, value);
                          });
                        },
                        child: Container(
                          height: 45.00,
                          // width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            color: maincolor,
                            borderRadius: BorderRadius.circular(5.00),
                          ),
                          child: Center(
                            child: Text(
                              "COLLECT CARGO",
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
              ),
            ],
          ),
        ));
  }
}

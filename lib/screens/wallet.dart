import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/theme/theme.dart';

import '../services/module.dart';
import 'addcash.dart';

class Wallet extends StatefulWidget {
  final UserModel userModel;

  const Wallet({Key key, @required this.userModel}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isLoading = false;
  dynamic currentdata;
  @override
  void initState() {
    super.initState();
    getAccount();
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

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  addlist(list) {
    var t = 0;
    for (var i = 0, _len = list.length; i < _len; i++) {
      t += int.parse(list[i].amount.split('.')[0]);
    }
    return t;
  }

  addlistusages(list) {
    var t = 0;
    for (var i = 0, _len = list.length; i < _len; i++) {
      t += list[i].amount.toInt();
    }
    return t;
  }

  String formatTimestamp(Timestamp timestamp) {
    assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }

  final upperTab = TabBar(tabs: <Tab>[
    Tab(
      // text: 'Available',
      icon: Text(
        "Deposits",
        style: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: fontsize3,
              fontWeight: FontWeight.w500),
        ),
      ),
    ),
    Tab(
      icon: Text(
        "Usages",
        style: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(
              color: Colors.black,
              fontSize: fontsize3,
              fontWeight: FontWeight.w500),
        ),
      ),
    ),
  ]);
  @override
  Widget build(BuildContext context) {
    // final appstate = Provider.of<AppState>(context);
    // appstate.getIToken();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            "My Wallet",
            style: GoogleFonts.nunitoSans(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: fontsize1,
                  fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    currentdata = null;
                  });
                  getAccount();
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
        ),
        body: currentdata == null
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Available Balance",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: fontcolor2,
                                fontSize: fontsize3,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "USD ${currentdata['balance'].toStringAsFixed(3)}",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: fontcolor,
                                fontSize: fontsizexl,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Top-Up Account with",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: fontcolor2,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return const WebViewTest(
                                      // userModel: widget.userModel,
                                      );
                                }));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child: Center(
                                        child: Icon(
                                      Ionicons.phone_portrait_outline,
                                      color: maincolor,
                                    )),
                                    decoration: BoxDecoration(
                                      // image: const DecorationImage(
                                      //   image: CachedNetworkImageProvider(
                                      //     mobileicon,
                                      //   ),
                                      //   fit: BoxFit.contain,
                                      // ),
                                      color: maincolor2,
                                      borderRadius: BorderRadius.circular(5.00),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Add Money",
                                    style: GoogleFonts.nunitoSans(
                                      textStyle: TextStyle(
                                          color: fontcolor2,
                                          fontSize: fontsize3,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .55,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: maincolor2,
                        automaticallyImplyLeading: false,
                        bottom: PreferredSize(
                          child: Column(
                            children: [
                              upperTab,
                            ],
                          ),
                          preferredSize: const Size.fromHeight(60.0),
                        ),
                        // bottom: upperTab,
                        title: Text(
                          "Transactions",
                          style: GoogleFonts.nunitoSans(
                            textStyle: TextStyle(
                                color: fontcolor,
                                fontSize: fontsizel,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      backgroundColor: maincolor2,
                      body: TabBarView(
                        children: [
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: currentdata['deposits'].length,
                            itemBuilder: (BuildContext context, index) {
                              dynamic singledata =
                                  currentdata['deposits'][index];
                              return ListTile(
                                title: Text(
                                  "${singledata['Receipt'].split('-')[0].toString()} Confirmed Top Up of ${singledata['Currency']} ${singledata['Amount']} to ${singledata['account']}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: fontcolor,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                trailing: Text(
                                  " ${(singledata['Timestamp'])}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: fontcolor,
                                        fontSize: fontsize3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => const Divider(),
                          ),
                          ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: currentdata['usages'].length,
                            itemBuilder: (BuildContext context, index) {
                              dynamic singledata = currentdata['usages'][index];
                              return ListTile(
                                title: Text(
                                  "${singledata['transactioncode'].toString().substring(0, 5)} Confirmed Use of USD ${singledata['amount'].toStringAsFixed(3)}  to ${singledata['account']}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: fontcolor,
                                        fontSize: fontsize2,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                trailing: Text(
                                  " ${DateFormat.yMMMd().add_jm().format(DateTime.parse(singledata['date'].toString()))}",
                                  style: GoogleFonts.nunitoSans(
                                    textStyle: TextStyle(
                                        color: fontcolor,
                                        fontSize: fontsize3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => const Divider(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

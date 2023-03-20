// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:transporter/components/componets.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/state.dart';
import 'package:transporter/services/module.dart';
import 'package:transporter/theme/theme.dart';
import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewTestState();
  }
}

class _WebViewTestState extends State<WebViewTest> {
  TextEditingController rateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _showDialog();
  }

  _showDialog() async {
    await Future.delayed(const Duration(milliseconds: 10));
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final appstate = Provider.of<AppState>(context, listen: false);
          return WillPopScope(
            onWillPop: () async {
              return MyNavigator.goToHomePage(context, appstate.userModel.id);
            },
            child: Scaffold(
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Payments",
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
                              "Payments Being Processed \nAre you sure you want to continue?",
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Select Currency",
                        style: GoogleFonts.nunitoSans(
                          textStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: fontsize2,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SelectionController( 
                      listdata: appstate.currencies,
                      listItem: appstate.currency,
                      title: "Currency",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextInputComponent(
                      title: "Amount",
                      titleController: rateController,
                      height: 50,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      debugPrint(appstate.currency.name);
                      debugPrint(rateController.text);
                      if (rateController.text.isEmpty) {
                        showInSnackBar("Ooops... ", context);
                      } else {
                        _webViewController.runJavascript(
                            'checkoutflutter("${appstate.globalData[0].token}","${appstate.userModel.indno}","production","${appstate.userModel.coorigin}","${appstate.userModel.email}","${appstate.userModel.phoneno}","${appstate.currency.name}","${rateController.text}")');
                        Navigator.pop(context);
                      }
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
                          "Continue",
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
          );
        });
  }

  WebViewController _webViewController;
  String filePath = 'files/test.html';
  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(context);

    return WillPopScope(
      onWillPop: () async {
        return MyNavigator.goToHomePage(context, appstate.userModel.id);
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: maincolor,
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: IconButton(
                onPressed: () {
                  MyNavigator.goToHomePage(context, appstate.userModel.id);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: backgroundcolor,
                )),
            title: Text(
              "Confirm Payment Initialization",
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: fontsize1,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //   },
          // ),
          body: WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
              _loadHtmlFromAssets();
            },
          )),
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

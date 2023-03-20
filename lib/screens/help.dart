import 'package:provider/provider.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../data/data.dart';
import '../models/state.dart';

import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool loggededin = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
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
    final appstate = Provider.of<AppState>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            "Help & Support",
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
                      "Contact Us",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            fontSize: fontsize1, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "We’re always here to answer any of your\nquestions, help you out and get some\nvaluable feedback",
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: fontsize2,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * .95,
                  // height: MediaQuery.of(context).size.height * .21,
                  decoration: BoxDecoration(
                    color: maincolor2,
                    borderRadius: BorderRadius.circular(5.00),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          size: 40,
                          color: maincolor,
                        ),
                        onTap: () {
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'info@safari-cargo.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject':
                                  'I am ${appstate.userModel.names} I need some help with my transporter app'
                            }),
                          );

                          launchUrl(emailLaunchUri);
                        },
                        title: Text(
                          "Send us an E-mail",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          "",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () async {
                          var whatsapp = "+254778000477";
                          String vartext =
                              "Hello I am ${appstate.userModel.names} I need some help with my transporter app,my account number is ${appstate.userModel.indno}";
                          final Uri _url = Uri.parse(
                              'whatsapp://send?phone=$whatsapp&text=$vartext');
                          if (!await launchUrl(_url)) {
                            showInSnackBar('Could not launch $_url');
                            throw 'Could not launch $_url';
                          }
                        },
                        leading: Icon(
                          Ionicons.logo_whatsapp,
                          size: 40,
                          color: maincolor,
                        ),
                        title: Text(
                          "Whatsapp us",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          "",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () async {
                          final Uri _url = Uri.parse(
                              'https://www.safari-cargo.com/frequently-asked-questions');
                          if (!await launchUrl(_url)) {
                            showInSnackBar('Could not launch $_url');
                            throw 'Could not launch $_url';
                          }
                        },
                        leading: Icon(
                          Ionicons.chatbox_outline,
                          size: 40,
                          color: maincolor,
                        ),
                        title: Text(
                          "FAQs",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: Text(
                          "Frequently Asked Questions",
                          style: GoogleFonts.nunitoSans(
                            textStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: fontsize2,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transporter/models/models.dart';

import '../components/componets.dart';
import '../data/data.dart';
import '../theme/theme.dart';

class History extends StatefulWidget {
  final UserModel userModel;

  const History({Key key, @required this.userModel}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        // bottom: upperTab,
        title: Text(
          "My History",
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
            Container(
              color: maincolor2,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .065,
              child: Row(children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Origin",
                  style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                        color: Colors.black45,
                        fontSize: fontsize1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Destination",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                          color: Colors.black45,
                          fontSize: fontsize1,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ]),
            ),
            CagoList(
              status: 'soldout',
              userModel: widget.userModel,
            ),
          ],
        ),
      ),
    );
  }
}

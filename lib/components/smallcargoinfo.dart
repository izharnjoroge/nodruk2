import 'package:transporter/data/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallCargoText extends StatelessWidget {
  final String title;
  final String text;

  const SmallCargoText({Key key, this.title, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(
        width: 20,
      ),
      Text(
        title,
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
          text,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                fontSize: fontsize1, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
    ]);
  }
}

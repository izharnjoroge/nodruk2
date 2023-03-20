import 'package:transporter/data/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallProfileDetails extends StatelessWidget {
  final String title;
  final String text;
  final bool editable;
  final Function edit;

  const SmallProfileDetails(
      {Key key, this.title, this.text, this.editable, this.edit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                color: Colors.black45,
                fontSize: fontsize1,
                fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(
          text,
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                fontSize: fontsize1, fontWeight: FontWeight.bold),
          ),
        ),
        trailing: editable
            ? IconButton(onPressed: edit, icon: const Icon(Icons.edit))
            : const SizedBox.shrink(),
      ),
    );
  }
}

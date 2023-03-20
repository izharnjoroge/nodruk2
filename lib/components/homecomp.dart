import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/data.dart';
import '../theme/theme.dart';

class HomeComponent extends StatelessWidget {
  final String imageurl;
  final String compname;
  final Function whattodo;

  const HomeComponent({Key key, this.imageurl, this.compname, this.whattodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whattodo,
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundcolor,
            borderRadius: BorderRadius.circular(3),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 23),
              CachedNetworkImage(
                imageUrl: imageurl,
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 15,
                child: Text(
                  compname,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.nunitoSans(
                    textStyle: TextStyle(
                        fontSize: fontsize4,
                        color: fontcolor2,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

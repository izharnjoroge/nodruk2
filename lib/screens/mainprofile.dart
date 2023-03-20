import 'package:cached_network_image/cached_network_image.dart';
import 'package:transporter/data/data.dart';
import 'package:transporter/models/models.dart';
import 'package:transporter/screens/screens.dart';
import 'package:transporter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProfile extends StatefulWidget {
  final UserModel userModel;
  const MainProfile({Key key, this.userModel}) : super(key: key);

  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(
                color: Colors.white,
                fontSize: fontsize1,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: userprofile,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return UserProfile(
                  userModel: widget.userModel,
                );
              }));
            },
            leading: const Icon(
              Icons.book_outlined,
            ),
            title: Text(
              "Account Details",
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: fontsize2,
                    fontWeight: FontWeight.bold),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const NotificationsScreen();
              }));
            },
            leading: const Icon(
              Icons.notifications,
            ),
            title: Text(
              "Notifications",
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: fontsize2,
                    fontWeight: FontWeight.bold),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          // const Divider(),
          // ListTile(
          //   leading: const Icon(
          //     Icons.security,
          //   ),
          //   title: Text(
          //     "Terms & Conditions",
          //     style: GoogleFonts.nunitoSans(
          //       textStyle: const TextStyle(
          //           color: Colors.black87,
          //           fontSize: fontsize2,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          //   trailing: const Icon(Icons.arrow_forward_ios_outlined),
          // ),
          const Divider(),
        ],
      ),
    );
  }
}

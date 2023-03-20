import 'package:flutter/material.dart';

var backgroundcolor = const Color(0xfff7f7fa);
var iconcolor = const Color(0xffefefef);
var fontcolor = const Color(0xff2c2c2c);
var fontcolor2 = Colors.black45;
// var maincolor = Colors.red[600];
var maincolor = const Color.fromRGBO(240,87,66, 1);
var maincolor2 = const Color.fromARGB(75, 228, 218, 217);
var cardcolors = const Color(0xfff5f5f5);
ThemeData theme() {
  return ThemeData(
    // primarySwatch: Colors.black,
    scaffoldBackgroundColor: backgroundcolor,
    primaryColor: maincolor,
    // iconTheme: IconThemeData(color: iconcolor),
    appBarTheme: AppBarTheme(
      color: backgroundcolor,
      elevation: 0,
      iconTheme: IconThemeData(color: maincolor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

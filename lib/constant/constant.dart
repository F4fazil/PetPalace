import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

Color bottom_naivigation_color = Colors.grey.shade200;
Color textfield_border_color = Colors.white;
Color btnColor = Color.fromARGB(255, 100, 208, 197);
Color textfieldicon = const Color.fromARGB(255, 41, 116, 112);
Color app_bc = Color.fromARGB(255, 100, 208, 197);

Color bc = Colors.green.shade50;

TextStyle subheader = GoogleFonts.poppins(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 15,
);
TextStyle buyandsell_details_text = GoogleFonts.openSans(
    textStyle: const TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 14,
));
const String publishkey =
    '';
const String catApiKey =
    "";
Color filtercolor = const Color.fromARGB(255, 116, 226, 215);

TextStyle style = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black);
TextStyle splashScreentext = GoogleFonts.openSans(
    fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black);
TextStyle little = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 15, color: Colors.grey);
TextStyle name = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    // Other text style properties...
    fontSize: 18,
    color: Colors.white,
  ),
);
TextStyle title = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black);
TextStyle description = const TextStyle(
    fontWeight: FontWeight.w300, fontSize: 17, color: Colors.black);
TextStyle buttontxtstyle =
    TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: buttontxtcolor);

class AppConstants {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void initialize(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}

// firebase notification server key
const String ServerKey =
    '4Xcx';

Color buttontxtcolor = Colors.white;
Color color = Colors.green.shade300;
Color appbarBackground = Colors.grey.shade200;
Color pickColor = Colors.white;
Color appbarColor = Colors.grey.shade200;
Color showColor = appbarColor;
Color activeColor = Colors.grey.shade300;
Color sentmsgColor = Colors.yellow.shade200;
Color getmsgColor = Colors.cyan.shade200;

//agora.io tokens api
const String _appId = '';
const String _token =
    "";
const String _channel = 'pet';
const String _appCertficate = "6f822a3efde346dfb522ad016760cd40";

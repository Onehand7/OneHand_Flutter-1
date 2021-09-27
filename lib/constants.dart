import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFF61cdff);
const kPrimaryLightColor = Color(0xFFc7f4ff);
const kPrimaryBorderColor = Color(0xFF1a83ff);

final Color colorBlue = Color(0xFF0ABEE2);
final Color colorWhite = Color(0xFFffffff);
const kGrabWhiteBoldMedium = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Sanomat Grab Web',
  color: Colors.white,
);
final kGrabWhiteRegularSmall =
    GoogleFonts.lato(fontSize: 20.0, color: Colors.white);

final kGrabBlackBoldSmall = GoogleFonts.lato(
    fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold);

final kGrabBlackBoldMedium = GoogleFonts.lato(
    fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

final kGrabBlackBoldLarge = GoogleFonts.lato(
    fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold);

final kGrabBlackRegularMedium =
    GoogleFonts.lato(fontSize: 20.0, color: Colors.black);

final kGrabBlackRegularSmall =
    GoogleFonts.lato(fontSize: 12.0, color: Colors.black);

fivePercentWidth(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.05;
}

percentHeight(BuildContext context, double percent) {
  return MediaQuery.of(context).size.height * percent;
}

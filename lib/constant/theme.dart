import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = Color(0XFF3F51B5);
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color redColor = Colors.red;

TextStyle blackTextStyle = GoogleFonts.poppins(color: blackColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: whiteColor);
TextStyle redTextStyle = GoogleFonts.poppins(color: redColor);

FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight bold = FontWeight.bold;

LinearGradient backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
);

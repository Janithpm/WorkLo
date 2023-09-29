import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class WorkLoTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xF4110DE3, <int, Color>{
      50: Color(0xF4110DE3),
      100: Color(0xF4110DE3),
      200: Color(0xF4110DE3),
      300: Color(0xF4110DE3),
      400: Color(0xF4110DE3),
      500: Color(0xF4110DE3),
      600: Color(0xF4110DE3),
      700: Color(0xF4110DE3),
      800: Color(0xF4110DE3),
      900: Color(0xF4110DE3),
    }),
  //   textTheme: TextTheme(
  //       headline2: GoogleFonts.poppins(
  //         color: Colors.black87,
  //         fontSize: 20,
  //       ),
  //       subtitle2: GoogleFonts.poppins(
  //         color: Colors.black54,
  //         fontSize: 16,
  //       )),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    // textTheme: TextTheme(
    //     headline2: GoogleFonts.poppins(
    //       color: Colors.white,
    //       fontSize: 20,
    //     ),
    //     subtitle2: GoogleFonts.poppins(
    //       color: Colors.white70,
    //       fontSize: 16,
    //     )),
  );
}

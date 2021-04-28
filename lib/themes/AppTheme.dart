import 'package:flutter/material.dart';
import 'package:wattcopy/themes/AppBarTheme.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData themeData = ThemeData(
  hintColor: Colors.white,
	primaryColor: Colors.deepOrange,
  buttonColor: Colors.deepOrange[300],
	appBarTheme: appBarTheme,
	scaffoldBackgroundColor: Colors.deepOrange,

	inputDecorationTheme: InputDecorationTheme(
    errorStyle: TextStyle(
      fontSize: 18,
      color: Colors.red[100],
    ),
    contentPadding: EdgeInsets.all(12),
    focusedErrorBorder: UnderlineInputBorder(),
    hintStyle: TextStyle(
      color: Colors.white54
    ),
    labelStyle: TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
	),

  buttonTheme: ButtonThemeData(
    buttonColor: Colors.deepOrange[300],
  ),

	elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.deepOrange[300]),
      padding: MaterialStateProperty.all(EdgeInsets.all(24)),
      foregroundColor: MaterialStateProperty.all(Colors.white), 
      textStyle: MaterialStateProperty.all(
        GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        )
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      )
    ),
  ),


  primaryTextTheme: TextTheme(
    headline6: GoogleFonts.revalia(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.0
    ),
  ),
);

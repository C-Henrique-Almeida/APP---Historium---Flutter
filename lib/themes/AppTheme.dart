import 'package:flutter/material.dart';
import 'package:wattcopy/themes/AppBarTheme.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
	hintColor: Colors.white,
	primaryColor: Colors.deepOrange,
	appBarTheme: appBarTheme,
	scaffoldBackgroundColor: Colors.deepOrange,

	inputDecorationTheme: InputDecorationTheme(
		fillColor: Colors.white,
	),

	elevatedButtonTheme: ElevatedButtonThemeData(
	style: ButtonStyle(
		shape: MaterialStateProperty.all(
			RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(24),
			),
		),
		backgroundColor: MaterialStateProperty.all(Colors.deepOrange[300]),
		padding: MaterialStateProperty.all(EdgeInsets.all(24)),
		textStyle: MaterialStateProperty.all(
			GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
		)
	)
)
);
/*
TextStyle(
        color: Colors.white,
        fontFamily: "Revalia",
        fontSize: 48
      ) 
 GoogleFonts.roboto(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
      )     
 */

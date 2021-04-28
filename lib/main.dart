import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wattcopy/ResetPasswordPage.dart';
import 'package:wattcopy/themes/AppTheme.dart';
import 'package:wattcopy/LandingPage.dart';
import 'package:wattcopy/LoginScreen.dart';
import 'package:wattcopy/RegisterScreen.dart';

void main() async {
  // It's better to just keep it here
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      theme: themeData,
      routes: {
        "/": (context) => LandingPage(),
        "/register": (context) => RegisterScreen(),
        "/login": (context) => LoginScreen(),
        '/password-reset': (context) => ResetPasswordPage()
      },
    ),
  );
}

//import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wattcopy/ResetPasswordPage.dart';
import 'package:wattcopy/LandingPage.dart';
import 'package:wattcopy/LoginScreen.dart';
import 'package:wattcopy/RegisterScreen.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
      ),
      routes: {
        "/": (context) => HomeScreen(),
        "/início": (context) => LandingPage(),
        "/register": (context) => RegisterScreen(),
        "/login": (context) => LoginScreen(),
        '/password-reset': (context) => ResetPasswordPage(),
        '/first_page': (context) => HomeScreen()
      },
    ),
  );
}

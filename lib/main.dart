import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:historium/pages/home_screen.dart';
import 'package:historium/pages/initial_page.dart';
import 'package:historium/pages/password_reset_page.dart';
import 'package:historium/pages/register_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MaterialApp(
    routes: {
      '/': (context) => InitialPage(),
      '/home': (context) => HomeScreen(),
      '/register': (context) => RegisterPage(),
      '/reset-password': (context) => ResetPasswordPage()
    },
  ));
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:historium/pages/home_page.dart';
import 'package:historium/pages/initial_page.dart';
import 'package:historium/pages/password_reset_page.dart';
import 'package:historium/pages/register_account_page.dart';
import 'package:historium/themes/AppTheme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
    theme: appTheme,
    routes: {
      '/': (context) => InitialPage(),
      '/home': (context) => HomePage(),
      '/register': (context) => RegisterAccountPage(),
      '/reset-password': (context) => ResetPasswordPage()
    },
  ));
}
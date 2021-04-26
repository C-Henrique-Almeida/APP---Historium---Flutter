import 'package:flutter/material.dart';
import 'package:wattcopy/common/WattcopyScaffold.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WattcopyScaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            optionButton(
                "Register", () => Navigator.pushNamed(context, ("/register"))),
            optionButton(
                "Login", () => Navigator.pushNamed(context, ("/login"))),
          ],
        ),
      ),
    );
  }

  Container optionButton(String text, void onPressed()) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: ElevatedButton(
        child: Text(text),
        onPressed: onPressed,
      ),
      width: double.infinity,
    );
  }
}

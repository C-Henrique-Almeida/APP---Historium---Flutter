import 'package:flutter/material.dart';
import 'CustomDrawer.dart';
import 'home_tab.dart';

class HomeScreen extends StatelessWidget {
  //final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )
      ],
    );
  }
}

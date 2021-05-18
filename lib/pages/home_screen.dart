import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'home_tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          bottomNavigationBar: CurvedNavigationBar(
              color: Colors.grey[600],
              backgroundColor: Colors.white,
              buttonBackgroundColor: Colors.grey[600],
              height: 50,
              items: <Widget>[
                Icon(Icons.home, size: 20, color: Colors.white),
                Icon(Icons.search, size: 20, color: Colors.white),
                Icon(Icons.create_rounded, size: 20, color: Colors.white),
                Icon(Icons.local_library_rounded, size: 20, color: Colors.white),
                Icon(Icons.notifications_rounded, size: 20, color: Colors.white)
              ],
              animationDuration: Duration(milliseconds: 200),
              animationCurve: Curves.easeInOutCirc,
              index: 0,
              onTap: (index) {
                debugPrint("index atual é $index");
              }),
        )
      ],
    );
  }
}

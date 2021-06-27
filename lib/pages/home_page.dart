import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'body.dart';
import 'create_page.dart';
import 'library_page.dart';
import 'notificacions_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    Body(),
    LibraryPage(),
    CreatePage(),
    SearchPage(),
    NotificacionsPage()
  ];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
    debugPrint("index atual: $selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        color: Colors.white,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 45,
        items: <Widget>[
          Icon(
            Icons.home, 
            size: 25, 
            color: _selectedIndex == 0 ? Colors.black : Colors.grey),
          Icon(
            Icons.local_library_rounded, 
            size: 25, 
            color: _selectedIndex == 1 ? Colors.black : Colors.grey),
          Icon(
            Icons.create_rounded, 
            size: 25, 
            color: _selectedIndex == 2 ? Colors.black : Colors.grey),
          Icon(
            Icons.search, 
            size: 25, 
            color: _selectedIndex == 3 ? Colors.black : Colors.grey),
          Icon(
            Icons.notifications_rounded, 
            size: 25, 
            color: _selectedIndex == 4 ? Colors.black : Colors.grey)
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.linear  
      ),
    );
  }
}

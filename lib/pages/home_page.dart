import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'body.dart';
import 'edit_book.dart';
import 'create_page.dart';
import 'library_page.dart';
import 'new_book.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onButtonPressed(),
        backgroundColor: Colors.grey,
        child: Icon(
            Icons.create_rounded,
            size: 25,
            color: _selectedIndex == 2 ? Colors.black : Colors.black),
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        color: Colors.black12,
        backgroundColor: Colors.black12,
        buttonBackgroundColor: Colors.black12,
        height: 45,
        items: <Widget>[
          Icon(
            Icons.home, 
            size: 25, 
            color: _selectedIndex == 0 ? Colors.white : Colors.grey),
          Icon(
            Icons.local_library_rounded, 
            size: 25, 
            color: _selectedIndex == 1 ? Colors.white : Colors.grey),
          Icon(
            Icons.search, 
            size: 25, 
            color: _selectedIndex == 2 ? Colors.white : Colors.grey),
          Icon(
            Icons.notifications_rounded, 
            size: 25, 
            color: _selectedIndex == 3 ? Colors.white : Colors.grey)
        ],
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.linear  
      ),
    );
  }
  _onButtonPressed() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        color: Color(0xFF737373),
        child: Container(
          child:  _buildBottomNavigationMenu(),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
          ),
        ),
      );
    });
  }

  Column _buildBottomNavigationMenu(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.attach_file_rounded,color: Colors.white,),
          title: Text('Coleção de Histórias'),
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditBook())
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.add_comment,color: Colors.white,),
          title: Text('Criar nova História'),
          onTap: (){
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewBook())
            );
          },
        ),
      ],
    );
  }
}

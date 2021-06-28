import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  @override
  _BodyPageState createState() {
    final state = _BodyPageState();
    state.controller = BodyPageController(state); 

    return state;
  }
}

class _BodyPageState extends State<Body> {
  BodyPageController controller;
  /*void showStories(){
    if () {
      
    } else {
    }
  }*/
  
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        appBar: AppBar(
            title: Text("Historium", style: GoogleFonts.revalia()),
            actions: [
              Icon(Icons.chat_bubble),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/home/edit-profile'),
                icon: Icon(Icons.account_circle)
              ),
            ],
            backgroundColor: Colors.black),
        body: FutureBuilder(
        future: controller.getBookInfo(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Map<String, String>>> snapshot
        ) {
          Widget widget;

          switch(snapshot.connectionState) {
            case ConnectionState.none:
              widget = Text('Carregando.');
              break;
            case ConnectionState.waiting:
              widget = Text('Carregando..');
              break;
            case ConnectionState.active:
              widget = Text('Carregando...');
              break;
            case ConnectionState.done:
              widget = _buildCards(context, snapshot);
              break;
          }

          return widget;
        }
      ),
    );
  }
  Widget _buildCards(
    BuildContext context,
    AsyncSnapshot<List<Map<String, String>>> snapshot
  ) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 10),

      itemCount: snapshot.data.length,

      separatorBuilder: (BuildContext context, int index) =>
      Divider(height: 20,),

      itemBuilder: (BuildContext context, int index) =>
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
          height: 250,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text(
                    '' + (snapshot.data[index])['genre'],
                    style: GoogleFonts.rokkitt(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                SizedBox(width: 10,),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Image.network(
                  (snapshot.data[index])['coverUrl'],
                  fit: BoxFit.contain,
                  width: 100,
                ),
                SizedBox(width: 10,),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Text(
                    '' + (snapshot.data[index])['title'],
                    style: GoogleFonts.rokkitt(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                SizedBox(width: 10,),
                ],
              ),
            ]
          ),
        ),
      )
    );
  }
}

class BodyPageController {
  final _BodyPageState state;

  BuildContext context;

  BodyPageController(this.state) {
    state.controller = this;
  }

  Future<List<Map<String, String>>> getBookInfo() async {
    return Future.value([
      {
        'title': 'A revolução dos bixos',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/81D0qNDMqPL.jpg',
        'author': 'George Orwell',
        'genre': 'Romance satírico',
        'readingProgress': '78%'
      },
      {
        'title': 'It - A Coisa',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/51z0s3GcvwL._SX342_SY445_QL70_ML2_.jpg',
        'author': 'Stephen King',
        'genre': 'Terror',
        'readingProgress': '36%'
      },
      {
        'title': '1984',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/819js3EQwbL.jpg',
        'author': 'George Orwell',
        'genre': 'Romance distópico',
        'readingProgress': '86%'
      }
    ]);
  }
}
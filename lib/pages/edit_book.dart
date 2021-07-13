import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final collection = FirebaseFirestore.instance.collection('books');

class EditBook extends StatefulWidget {

  @override
  EditBookState createState() {
    final state = EditBookState();
    state.controller = EditBookController(state);

    return state;
  }
}

class EditBookState extends State<EditBook> {

  void getDocs() {
    collection.get(
        /*{
          'title': ,
          'pages': ,
        }*/
    );
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditBook())
    );
  }

  EditBookController controller;

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
      appBar: AppBar(
          title: Text('Sua Coleção', style: GoogleFonts.revalia()),
          backgroundColor: Colors.black
      ),
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
          Divider(height: 10,),

      itemBuilder: (BuildContext context, int index) =>
          GestureDetector(
            onTap: () => print('Call some page'),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                height: 230,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Image.network(
                      (snapshot.data[index])['coverUrl'],
                      fit: BoxFit.contain,
                      width: 120,
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (snapshot.data[index])['title'],
                          style: GoogleFonts.rokkitt(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                              (snapshot.data[index])['readingProgress'] +' '+ 'páginas',
                          style: GoogleFonts.rokkitt(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

class EditBookController {
  final EditBookState state;

  BuildContext context;

  EditBookController(this.state) {
    state.controller = this;
  }

  Future<List<Map<String, String>>> getBookInfo() async {
    return Future.value([
      {
        'title': 'A revolução dos bixos',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/81D0qNDMqPL.jpg',
        'author': 'George Orwell',
        'readingProgress': '78%'
      },
      {
        'title': 'It - A Coisa',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/51z0s3GcvwL._SX342_SY445_QL70_ML2_.jpg',
        'author': 'Stephen King',
        'readingProgress': '36%'
      }
    ]);
  }
}
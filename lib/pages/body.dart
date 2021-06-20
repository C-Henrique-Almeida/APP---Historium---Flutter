import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              int genero = index + 1;
              return Card(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text('Gênero $genero'),
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                              Text('Nome do livro')
                            ),
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child:
                              Text('Nome do livro')
                            )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

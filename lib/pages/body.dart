import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: null,
            title: Text(
              "Historium",
              style: TextStyle(fontFamily: 'Revalia'),
            ),
            actions: [
              Padding(padding: const EdgeInsets.all(20.0)),
              Icon(Icons.chat_bubble),
              Icon(Icons.account_circle)
            ],
            backgroundColor: Colors.black),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[400],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Text('Gênero $index'),
                      SizedBox(height: 100),
                      Text('Nome do livro')
                    ],
                  ),
                ),
              );
            }));
  }
}

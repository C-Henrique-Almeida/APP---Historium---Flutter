import 'package:flutter/material.dart';

class EditBook extends StatefulWidget {

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  @override
  Widget build(BuildContext context) {

    //var dividedTiles = ListTile.divideTiles(tiles: tiles)

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar obras'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: ListTile(
          leading: Icon(Icons.folder),
          title: Text("Titulo do Livro"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditBook())
            );
          },
        ),
      ),
    );
  }
}
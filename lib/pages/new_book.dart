import 'package:flutter/material.dart';

class NewBook extends StatefulWidget {
    @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {

  bool _editando = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Novo Livro'),
            backgroundColor: Colors.black
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.folder_outlined),
                iconSize: 140.0,
                splashColor: Colors.white,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Titulo da História", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                 // titulo da historia = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Descrição da História", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                // descrição da historia = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Gênero da História", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                //  genero da historia = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Direitos autorais", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                //  direitos autorais = text;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Idioma", border: OutlineInputBorder(),labelStyle: TextStyle(color: Colors.white)),
                onChanged: (text){
                  _editando = true;
                  //  idioma = text;
                },
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Adicionar capitulo'),
                    onPressed: (){},
                    color: Colors.black87,
                  )
                ]
              )
            ],
          )
        )
      )
    );
  }

  Future<bool> _requestPop(){
    if(_editando){
      showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        );
        return Future.value(false);
    }   else{
        return Future.value(true);
    }
  }
}
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(0, 0, 0, 0),
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          ),
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
            _buildDrawerBack(),
            ListView(
              padding: EdgeInsets.only(left: 32.0, top:  16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 0.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 0.0),
                  height: 170.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text("Historium",
                          style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)
                          )
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Bem-Vindo!",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Estilos >",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0
                                ),
                              ),
                              Text(
                                "Comunidade",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0
                                ),
                              ),
                              Text(
                                "Ajuda",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0
                                ),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ],
      ),
    );
  }
}
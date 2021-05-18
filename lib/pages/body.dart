import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tendências", 
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)
          ),
        ],
        ),
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Ficção científica", 
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)
          ),
        ],
        ),
        Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "Terror", 
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)
          ),
        ],
        ),
      ],
    );
  }
}

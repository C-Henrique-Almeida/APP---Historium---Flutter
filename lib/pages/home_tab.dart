import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tendências", 
            style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)
          ),
          Text(
            "Ficção científica", 
            style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)
          ),
          Text(
            "Terror", 
            style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold)
          ),
        ],
        ),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.logout),
                )],
              floating: true,
              backgroundColor: Colors.black,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Historium"),
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}

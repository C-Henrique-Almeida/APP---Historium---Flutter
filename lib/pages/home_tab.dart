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
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.logout),
                )
              ],
              floating: true,
              backgroundColor: Colors.black,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Início"),
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/controller/widgetControllers/library_page_controller.dart';


class LibraryPage extends StatefulWidget {

  @override
  LibraryPageState createState() {
    final state = LibraryPageState();
    state.controller = LibraryPageController(state); 

    return state;
  }
}

class LibraryPageState extends State<LibraryPage> {
  LibraryPageController controller;

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca', style: GoogleFonts.revalia()),
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
            case ConnectionState.waiting:
            case ConnectionState.active:
              widget = Container(
								alignment: Alignment.center,
								child: Text('Carregando...'),
							);
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
      GestureDetector(
				onTap: () => print('Call some page'),
				child: Card(
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(30)
					),
					child: Container(
						height: 250,
						padding: EdgeInsets.symmetric(vertical: 20),
						child: Row(
							children: [
								SizedBox(width: 20,),
								Image.network(
									(snapshot.data[index])['coverUrl'],
									fit: BoxFit.contain,
									width: 100,
								),
								SizedBox(width: 10,),
								Column(
									mainAxisAlignment: MainAxisAlignment.spaceAround,
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											'Livro:\n' + (snapshot.data[index])['title'],
											style: GoogleFonts.rokkitt(
												fontSize: 20,
												fontWeight: FontWeight.w500
											),
										),
										Text(
											'Autor:\n' + (snapshot.data[index])['author'],
											style: GoogleFonts.rokkitt(
												fontSize: 20,
												fontWeight: FontWeight.w500
											),
											textAlign: TextAlign.justify,
										),
										Text(
											'Progresso de leitura:\n' + 
											(snapshot.data[index])['readingProgress'],
											style: GoogleFonts.rokkitt(
												fontSize: 20,
												fontWeight: FontWeight.w500
											),
										),
									],
								),
								SizedBox(width: 20,),
							],
						),
					),
				),
			),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:historium/controller/outputModels/StoryDetailsOutput.dart';
import 'package:historium/controller/widgetControllers/book_details_page_controller.dart';

class BookDetailsPage extends StatefulWidget {
	final String storyId;

	BookDetailsPage(this.storyId);

	@override
	_BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsPage> {

	final controller = BookDetailsPageController();

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
        body: FutureBuilder(
					future: controller.loadStoryInfo(widget.storyId),
					builder: (BuildContext context, AsyncSnapshot<StoryDetailsOutput> snapshot) {
						Widget widget;

						switch(snapshot.connectionState){
						  case ConnectionState.none:
						  case ConnectionState.waiting:
						  case ConnectionState.active:
						    widget = _buildLoadingScreen(context);
								break;
						  case ConnectionState.done:
						    widget = _buildPage(context, snapshot.data);
						    break;
						}

						return widget;
					}
				),
    );
	}

	Widget _buildLoadingScreen(BuildContext context) {
		return Container(
			alignment: Alignment.center,
			child: Text(
				'Carregando...',
			),
		);
	}

	Widget _buildPage(BuildContext context, StoryDetailsOutput output) {
		final bodyWidth = 
			MediaQuery.of(context).size.width;

		return SingleChildScrollView(
			child: Container(
				padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
				width: bodyWidth,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
						Image.network(
							output.coverUrl,
							height: 400,
						),
						SizedBox(height: 22,),
						Text(
							output.title.toUpperCase(),
							style: GoogleFonts.roboto(
								fontSize: 20
							),
						),
						SizedBox(height: 30,),
						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Icon(Icons.account_circle),
								SizedBox(width: 10,),
								Text(
									output.authorName,
									style: GoogleFonts.roboto(
										fontSize: 20
									)
								),
							],
						),
						SizedBox(height: 50,),
						Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								Expanded(
									child: Wrap(
										runSpacing: 5,
										spacing: 5,
										children: _createChipList(output.genres),
									),
								),
								FloatingActionButton(
									child: Icon(Icons.star_outline),
									backgroundColor: Colors.white,
									onPressed: () => print('wee'),
									elevation: 0,
								)
							],
						),
						SizedBox(height: 30,),
						Text(
							output.summary,
							textAlign: TextAlign.justify,
							style: GoogleFonts.roboto(
								fontSize: 20
							),
						),
						FractionallySizedBox(
							widthFactor:0.8,
							child: ElevatedButton(
								child: Text('Ler'),
								style: ButtonStyle(
									backgroundColor: MaterialStateProperty.all(Colors.black45),
								),
								onPressed: () => print('Call reading screen'),
							),
						)
					],
				),
			)
		);
	}

	List<Widget> _createChipList(List<String> favouriteGenres) {
		final chipList = <Chip> [];

		favouriteGenres.forEach((genre) => chipList.add(Chip(
			label: Text(genre),
			backgroundColor: Colors.black45
		)));

		return chipList;
	}
}
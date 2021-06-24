import 'package:google_fonts/google_fonts.dart';
import 'package:historium/model/stories.dart';
import 'package:historium/model/storiesData.dart';
import 'package:flutter/material.dart';
import 'package:historium/pages/widgets/searchWidget.dart';

class SearchPage extends StatefulWidget {

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Story> stories;
  String query = '';

  @override
  void initState() {
    super.initState();

    stories = allStories;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Historium", style: GoogleFonts.revalia()),
          backgroundColor: Colors.black
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: stories.length,
                itemBuilder: (context, index) {
                  final story = stories[index];

                  return buildStory(story);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Título ou Autor',
        onChanged: searchStory,
      );

  Widget buildStory(Story story) => ListTile(
        leading: Image.network(
          story.coverUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(story.title),
        subtitle: Text(story.author),
      );

  void searchStory(String query) {
    final stories = allStories.where((story) {
    final titleLower = story.title.toLowerCase();
    final authorLower = story.author.toLowerCase();
    final searchLower = query.toLowerCase();

    return titleLower.contains(searchLower) ||
        authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.stories = stories;
    });
  }
}
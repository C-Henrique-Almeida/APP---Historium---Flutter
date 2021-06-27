import 'package:flutter/material.dart';
import 'package:historium/model/entity/historiesData.dart';
import 'package:historium/model/histories.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black12,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Título ou Autor",
              border: InputBorder.none,
              prefix: Icon(Icons.search),
            ),
            onTap: () {
              showSearch(context: context, delegate: BookSearch());
            },
          ),
        ),
      ),
    );
  }
}

class BookSearch extends SearchDelegate<Book> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mylist = BookItem.loadBookItem();
    return ListView.builder(
        itemCount: mylist.length,
        itemBuilder: (context, index) {
          final BookItem listitem = mylist[index];
          return ListTile(title: Text(listitem.title),
          );
        });
  }
}

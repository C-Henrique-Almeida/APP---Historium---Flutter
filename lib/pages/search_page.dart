import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:historium/controller/widgetControllers/book_details_page_controller.dart';
import 'package:historium/model/services/BookDataService.dart';
import 'package:historium/pages/book_details_page.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
									Navigator.push(
										context,
										MaterialPageRoute(
											builder: (_context) => BookDetailsPage(snapshotData.docs[index].id,)
										)
									);
                },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                    NetworkImage(snapshotData.docs[index]['cover']),
                ),
                title: Text(
                  snapshotData.docs[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
                ),
                subtitle: Text(
                  snapshotData.docs[index]['author'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
                ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          GetBuilder<BookDataService>(
              init: BookDataService(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      val.queryData(searchController.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    },
                  );
              })
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Título ou Autor',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              ),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12)
          ),
          controller: searchController,
        ),
        backgroundColor: Colors.black,
      ),
      body: isExecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text('',
                    style: TextStyle(color: Colors.white, fontSize: 30.0)),
              ),
            ),
    );
  }
}

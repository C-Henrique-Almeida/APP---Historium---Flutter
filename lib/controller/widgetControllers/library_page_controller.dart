import 'package:flutter/material.dart';
import 'package:historium/pages/book_details_page.dart';
import 'package:historium/pages/library_page.dart';

class LibraryPageController {
  final LibraryPageState state;

  BuildContext context;

  LibraryPageController(this.state) {
    state.controller = this;
  }

  Future<List<Map<String, String>>> getBookInfo() async {
    return Future.value([
      {
        'title': 'A revolução dos bixos',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/81D0qNDMqPL.jpg',
        'author': 'George Orwell',
        'readingProgress': '78%'
      },
      {
        'title': 'It - A Coisa',
        'coverUrl': 'https://images-na.ssl-images-amazon.com/images/I/51z0s3GcvwL._SX342_SY445_QL70_ML2_.jpg',
        'author': 'Stephen King',
        'readingProgress': '36%'
      }
    ]);
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:historium/model/services/UserService.dart';
import 'package:historium/pages/library_page.dart';

class LibraryPageController {

  final LibraryPageState state;
	final _userService = UserService();
	final _authentication = FirebaseAuth.instance;

  BuildContext context;

  LibraryPageController(this.state) {
    state.controller = this;
  }

  Future<List<Map<String, String>>> getBookInfo() async {
		final library = (await _userService.loadUser(
			_authentication.currentUser.uid,
			eagerLoad: true
		)).library;

		final bookInfo = List<Map<String, String>>.from(library.map((readingProgress) => {
			'title': readingProgress.book.title,
			'coverUrl': readingProgress.book.cover,
			'author': readingProgress.book.author,
			'readingProgress': '${readingProgress.percentage.ceil()}%',
		}));

    return bookInfo;
  }
}
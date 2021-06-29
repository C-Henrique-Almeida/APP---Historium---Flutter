import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:historium/pages/book_details_page.dart';

class SearchPageController {
	void callBookDetailsPage(BuildContext context, String storyId) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (BuildContext context) => BookDetailsPage(storyId)
			)
		);
	}
}
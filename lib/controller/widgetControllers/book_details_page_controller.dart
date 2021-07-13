import 'package:historium/controller/outputModels/StoryDetailsOutput.dart';
import 'package:historium/model/services/BookService.dart';

class BookDetailsPageController {
	Future<StoryDetailsOutput> loadStoryInfo(String id) async {
		final bookService = BookService();
		final storyOutput = StoryDetailsOutput();
		final book = await bookService.loadBook(id);

		storyOutput.title = book.title;
		storyOutput.authorName = book.author;
		storyOutput.coverUrl = book.cover;
		storyOutput.genres = book.genres;
		storyOutput.summary = book.description;

		return storyOutput;
	}
}
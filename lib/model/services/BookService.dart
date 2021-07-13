import 'package:historium/model/entity/Book.dart';
import 'package:historium/model/helpers/BookHelper.dart';

class BookService {
	final _bookHelper = BookHelper();

	Future<void> registerBook(Book book) async {
		await _bookHelper.save(book);
	}

	Future<Book> loadBook(String id) async {
		return await _bookHelper.load(id);
	}

	Future<void> deleteBook(String id) async {
		await _bookHelper.delete(id);
	}

	Future<List<Book>> index() async {
		return await _bookHelper.index();
	}
}
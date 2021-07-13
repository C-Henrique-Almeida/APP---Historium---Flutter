import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:historium/model/entity/Book.dart';

class BookHelper {
	final _firestore = FirebaseFirestore.instance;

	static const collectionName = 'books';

	Future<void> save(Book book) async {
		if(book.id == null) {
			await _firestore
			.collection(collectionName)
			.add(book.toMap());
		}
		else {
			await _firestore
			.collection(collectionName)
			.doc(book.id)
			.set(book.toMap());
		}
	}

	Future<Book> load(String id) async {
		final bookMap =
			(await _firestore.collection(collectionName).doc(id).get()).data();

		final book = Book.fromMap(bookMap);
		book.id = id;

		return book;
	}

	Future<void> delete(String id) async {
		await _firestore
		.collection(collectionName)
		.doc(id)
		.delete();
	}

	Future<List<Book>> index() async {
		final bookList = <Book> [];
		final bookSnapshots = await _firestore.collection(collectionName).get();

		for(QueryDocumentSnapshot<Map<String, dynamic>> snapshot in bookSnapshots.docs) {
			var book = Book.fromMap(snapshot.data());
			book.id = snapshot.id;
			bookList.add(book);
		}

		return bookList;
	}
}
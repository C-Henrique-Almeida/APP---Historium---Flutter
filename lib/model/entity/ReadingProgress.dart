import 'package:historium/model/entity/Book.dart';

class ReadingProgress {
	Book book;
	int readPages;

	ReadingProgress();

	ReadingProgress.fromMap(Map<String, dynamic> map) {
		readPages = map['readPages'];
		book = map['book'];
	}

	Map<String, dynamic> toMap() => {
		'readPages': readPages,
		'book': book.id
	};

	double get percentage {
		return readPages / book.pages * 100;
	}

	@override
  String toString() {
		return '''{
			readPages: ${readPages ?? 'null'},
			book: ${book ?? 'null'}
		}''';
  }
}
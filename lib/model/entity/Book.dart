class Book {
	String	id;
	String	title;
	String author;
	String	cover;
	int			pages;
	String	description;
	String	copyright;
	String	language;
	List<String> genres;

	Book();

	Book.fromMap(Map<String, dynamic> map){ 
		title = map['title'];
		author = map['author'];
		cover = map['cover'];
		pages = map['pages'];
		description = map['description'];
		copyright = map['copyright'];
		language = map['language'];
		genres = List<String>.from(map['genres']);
	}

	Map<String, dynamic> toMap() => {
		'title': title,
		'author': author,
		'cover': cover,
		'pages': pages,
		'description': description,
		'copyright': copyright,
		'language': language,
		'genres': genres,
	};
}
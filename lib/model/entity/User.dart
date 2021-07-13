import 'package:historium/model/entity/ReadingProgress.dart';

class User{

	String id;
  String username;
  String profilePictureUrl;
  DateTime birthDate;
	List<ReadingProgress> library;

	User();

  List<String> favouriteGenres;
	
	User.fromMap(Map<String, dynamic> map) {
		id = map['id'];
		profilePictureUrl = map['profilePictureUrl'];
		username = map['username'];
		birthDate = DateTime.fromMillisecondsSinceEpoch(map['birthDate']);

		favouriteGenres = List<String>.from(map['favouriteGenres']);
  }

  Map<String, dynamic> toMap() {
		final map = {
			'uid': id,
			'profilePictureUrl': profilePictureUrl,
			'username': username,
			'birthDate': birthDate.millisecondsSinceEpoch,
			'favouriteGenres': favouriteGenres,
		};

		if(library != null) {
			map['library'] = library.map(
				(readingProgress) => readingProgress.toMap()
			);
		}

		return map;
	}

}
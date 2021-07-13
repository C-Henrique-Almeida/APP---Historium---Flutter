class User{

	String id;
  String username;
  String profilePictureUrl;
  DateTime birthDate;

	User();

  List<String> favouriteGenres;
	  User.fromMap(Map<String, dynamic> map) {
		id = map['id'];
		profilePictureUrl = map['profilePictureUrl'];
		username = map['username'];
		birthDate = DateTime.fromMillisecondsSinceEpoch(map['birthDate']);

		favouriteGenres = List<String>.from(map['favouriteGenres']);
  }

  Map<String, dynamic> toMap() => {
		'uid': id,
		'profilePictureUrl': profilePictureUrl,
		'username': username,
		'birthDate': birthDate.millisecondsSinceEpoch,
		'favouriteGenres': favouriteGenres,
	};

}
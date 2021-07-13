class Story {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String storyBodyUrl;
  final String genre;

  const Story(
      {this.id,
      this.title,
      this.author,
      this.coverUrl,
      this.storyBodyUrl,
      this.genre});

  factory Story.fromJson(Map<String, dynamic> json) => Story(
      id: json['id'],
      author: json['author'],
      title: json['title'],
      coverUrl: json['coverUrl'],
      storyBodyUrl: json['storyBodyUrl'],
      genre: json['genre'],
    );

  Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'storyBodyUrl': storyBodyUrl,
      'genre': genre
    };
}
class Book {
  final int id;
  final String title;
  final String author;
  final String image;

  const Book({
    this.id,
    this.title,
    this.author,
    this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
      id: json['id'],
      author: json['author'],
      title: json['title'],
      image: json['image']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'image': image,
      };
}

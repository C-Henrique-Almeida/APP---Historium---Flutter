class BookItem {
  final int id;
  final String title;
  final String author;
  final String image;

  BookItem({
    this.id,
    this.title,
    this.author,
    this.image,
  });

  static List<BookItem> loadBookItem() {
    var bi = <BookItem>[
      BookItem(
          id: 1,
          author: 'Stephen King',
          title: 'it - A Coisa',
          image:
              'https://images-na.ssl-images-amazon.com/images/I/51z0s3GcvwL._SX342_SY445_QL70_ML2_.jpg'),
      BookItem(
          id: 2,
          author: 'George Orwell',
          title: 'A Revolução dos Bichos',
          image:
              'https://images-na.ssl-images-amazon.com/images/I/81D0qNDMqPL.jpg')
    ];
    return bi;
  }
}

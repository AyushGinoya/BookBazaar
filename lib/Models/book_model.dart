class Book {
  String? id;
  String? img_url_book;
  String? name;
  String? author;
  double? price;

  Book({
    this.id,
    this.img_url_book,
    this.name,
    this.author,
    this.price,
  });

  Book.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    img_url_book = map['img_url_book'];
    name = map['name'];
    author = map['author'];
    price = map['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'img_url_book': img_url_book,
      'name': name,
      'author': author,
      'price': price,
    };
  }
}

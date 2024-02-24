class Book {
  final String id;
  final String imageUrl;
  final String name;
  final String author;
  final double price;

  Book({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.author,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] as String,
        imageUrl: json['imageUrl'] as String,
        name: json['name'] as String,
        author: json['author'] as String,
        price: (json['price'] as num).toDouble());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'author': author,
      'price': price,
    };
  }
}

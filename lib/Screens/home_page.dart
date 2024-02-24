import 'package:flutter/material.dart';
import 'package:bookbazaar/Models/book_model.dart';
import 'package:bookbazaar/Helper/custom_card.dart'; // Make sure this path is correct

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Book> books = [
    Book(
      id: '456',
      imageUrl:
          'assets/images/lovepik-learning-english-books-material-png-image_400234770_wh1200.png',
      name: 'Om ni Mahanta',
      author: 'John Doe',
      price: 39.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return CustomBookCard(
            id: book.id,
            imageUrl: book.imageUrl,
            bookName: book.name,
            authorName: book.author,
            price: book.price,
          );
        },
      ),
    );
  }
}

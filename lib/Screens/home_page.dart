import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:bookbazaar/Models/book_model.dart';
import 'package:bookbazaar/Helper/custom_card.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    var url = Uri.parse('http://10.0.2.2:3000/get-all-books');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        log(jsonResponse);

        final booksJson = jsonResponse['books'] as List;
        setState(() {
          books = booksJson.map((json) => Book.fromJson(json)).toList();
        });
      } else {
        throw Exception('Failed to load books from the server');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return CustomBookCard(
              id: book.id ?? 'Unknown ID',
              imageUrl: book.img_url_book ?? 'assets/default_image.png',
              bookName: book.name ?? 'Unknown Title',
              authorName: book.author ?? 'Unknown Author',
              price: book.price ?? 0.0,
            );
          },
        ),
      ),
    );
  }
}

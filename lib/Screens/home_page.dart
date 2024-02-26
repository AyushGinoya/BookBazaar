import 'dart:convert';
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
      print('1');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse.toString());

        final booksJson = jsonResponse['books'] as List;
        if (mounted) {
          setState(() {
            books = booksJson.map((json) => Book.fromJson(json)).toList();
          });
        }
      } else {
        throw Exception('Failed to load books from the server');
      }
    } catch (e) {
      print(e.toString());
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
              imageUrl: book.img_url_book ?? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shutterstock.com%2Fdiscover%2Ffree-nature-images&psig=AOvVaw3oE6ze58Xb9P0e1gFkLd48&ust=1709051192917000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCPCo9YC2yYQDFQAAAAAdAAAAABAE',
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

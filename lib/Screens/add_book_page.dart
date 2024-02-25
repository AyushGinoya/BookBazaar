import 'package:bookbazaar/Helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _bookNameController.dispose();
    _authorNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> createUser() async {
  

   

    var url = Uri.parse('http://localhost:3000/signup');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username cannot be empty")));
    } else {
      throw Exception('Failed to create user. Error: ${response.body}');
    }
  }

  void _addBook() {
    print('Book Name: ${_bookNameController.text}');
    print('Author Name: ${_authorNameController.text}');
    print('Price: ${_priceController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        backgroundColor: kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Craft Your Masterpiece")],
              ),
              TextField(
                controller: _bookNameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Book Name',
                  hintStyle: kBodyText,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: kBodyText.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _authorNameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Author Name',
                  hintStyle: kBodyText,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: kBodyText.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: 'Price',
                  hintStyle: kBodyText,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: kBodyText.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black87, // Text Color
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: _addBook,
                child: const Text(
                  'Add Book',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

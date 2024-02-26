import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:bookbazaar/Helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? imageFile;
  String? imgUrl;

  @override
  void dispose() {
    _bookNameController.dispose();
    _authorNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              leading: const Icon(Icons.photo_album),
              title: const Text("Select from Gallery"),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addBook() async {
    // Book book = Book(
    //   name: _bookNameController.text.trim(),
    //   author: _authorNameController.text.trim(),
    //   price: double.tryParse(_priceController.text.trim()),
    //   img_url_book: imgBase64,
    // );

    var stream = http.ByteStream(imageFile!.openRead());
    stream.cast();

    var length = await imageFile!.length();

    var uri = Uri.parse('http://10.0.2.2:3000/add-book');

    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = _bookNameController.text.trim();
    request.fields['author'] = _authorNameController.text.trim();
    request.fields['price'] = _priceController.text.trim();

    var multiport = http.MultipartFile('img_url_book', stream, length,
        filename: (imageFile!.path));

    request.files.add(multiport);

    var response = await request.send();
    setState(() {
      _bookNameController.clear();
      _authorNameController.clear();
      _priceController.clear();
      imageFile = null;
    });

    log(response.stream.toString());
    if (response.statusCode == 200) {
      log('image uploaded');
      var responseData = await response.stream.bytesToString();
      log(responseData);
    } else {
      log('failed');
    }
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
                onTap: () {
                  showPhotoOptions();
                },
                child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showPhotoOptions();
                      },
                      child: Container(
                        height: 300, // Adjust the size as needed
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey, // Color of the border
                            width: 1, // Width of the border
                          ),
                        ),
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    17), // Match container border radius
                                child: FutureBuilder<Uint8List>(
                                  future: imageFile!.readAsBytes(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Uint8List> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.data != null) {
                                      return Image.memory(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      );
                                    } else if (snapshot.error != null) {
                                      // Handle errors or display a placeholder
                                      return const Text('Error loading image');
                                    } else {
                                      // Display a placeholder or loading indicator
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ))
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  SizedBox(
                                      height:
                                          10), // Space between icon and text
                                  Text(
                                    "Tap to select an image",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )),
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

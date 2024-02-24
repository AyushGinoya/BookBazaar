import 'package:flutter/material.dart';

class CustomBookCard extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String bookName;
  final String authorName;
  final double price;

  const CustomBookCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.bookName,
    required this.authorName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Image.network(imageUrl,
              //     width: 100, height: 150, fit: BoxFit.cover),
              Image.asset(
                imageUrl,
              ),
              const SizedBox(height: 8),
              Text(bookName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(authorName,
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 4),
              Text('\$$price',
                  style: const TextStyle(fontSize: 16, color: Colors.green)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      print("Buy clicked");
                    },
                    child: const Text('Buy'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add your add to cart action here
                      print("Cart clicked");
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

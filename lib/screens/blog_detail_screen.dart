import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;

  const BlogDetailScreen(
      {super.key, required this.title, required this.imageUrl});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool isFavorite = false; // Track favorite status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border, // Change icon based on state
              color: isFavorite
                  ? Colors.red
                  : Colors.black, // Change color based on state
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; // Toggle favorite status
              });
            },
          ),
          const SizedBox(width: 20),
        ],
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Image.network(
              widget.imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  height: 200,
                  child: const Center(
                    child: Text("Image not available",
                        style: TextStyle(fontSize: 18)),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut purus eget sapien egestas. Nullam nec nunc nec libero tincidunt ultricies nec nec nunc. Nullam nec nunc nec libero tincidunt ultricies nec nec nunc.",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            // Add more widgets to display additional details if needed
          ],
        ),
      ),
    );
  }
}

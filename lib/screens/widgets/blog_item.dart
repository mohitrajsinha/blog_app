import 'package:blog_app/screens/blog_detail_screen.dart';
import 'package:flutter/material.dart';

class BlogItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const BlogItem({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BlogDetailScreen(title: title, imageUrl: imageUrl),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder:
                    'assets/work-in-progress.gif', // Make sure to add this image to your assets
                image: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

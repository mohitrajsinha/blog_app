class BlogPost {
  final String title;
  final String imageUrl;

  BlogPost({
    required this.title,
    required this.imageUrl,
  });

  // Ensure the return type is specified as BlogPost
  static BlogPost fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}

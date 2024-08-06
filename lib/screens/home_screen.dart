import 'package:blog_app/bloc/blog_bloc.dart';
import 'package:blog_app/blog_model.dart';
import 'package:blog_app/screens/widgets/blog_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch blog posts when the screen initializes
    context.read<BlogBloc>().add(FetchBlogPosts());
  }

  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (listScrollController.hasClients) {
            final position = listScrollController.position.minScrollExtent;
            listScrollController.animateTo(
              position,
              duration: const Duration(seconds: 3),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: const Icon(Icons.arrow_upward),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    radius: 20,
                    child: Image(image: AssetImage('assets/man.png'))),
                Icon(Icons.menu),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Your stories, your voice—share your thoughts with the world.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Suggested",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<BlogBloc, BlogState>(
                builder: (context, state) {
                  if (state is BlogLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BlogLoaded) {
                    final List<BlogPost> posts = state.posts;
                    return ListView.builder(
                      controller: listScrollController,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return BlogItem(
                          imageUrl: posts[index].imageUrl,
                          title: posts[index].title,
                        );
                      },
                    );
                  } else if (state is BlogError) {
                    return const Center(
                        child: Text('Oops! Something went wrong.'));
                  } else {
                    return const Center(child: Text('No blogs available.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

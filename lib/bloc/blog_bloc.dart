import 'package:blog_app/blog_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
 // Import Dio package

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final Dio _dio = Dio(); // Create a Dio instance

  BlogBloc() : super(BlogInitial()) {
    on<FetchBlogPosts>((event, emit) async {
      emit(BlogLoading()); // Indicate loading state

      try {
        final List<BlogPost> posts = await _fetchBlogPosts();
        emit(BlogLoaded(posts)); // Emit loaded state with fetched posts
      } catch (error) {
        emit(BlogError('Failed to fetch blog posts')); // Emit error state
      }
    });
  }

  Future<List<BlogPost>> _fetchBlogPosts() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'x-hasura-admin-secret': adminSecret,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final List<dynamic> blogs = data['blogs'] as List<dynamic>;
        return blogs
            .map((json) => BlogPost.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load blog posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching blog posts: $e');
    }
  }
}

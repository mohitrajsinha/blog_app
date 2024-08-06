part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogLoaded extends BlogState {
  final List<BlogPost> posts; 

  BlogLoaded(this.posts);
}

final class BlogError extends BlogState {
  final String message;

  BlogError(this.message);
}



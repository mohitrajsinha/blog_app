import 'package:blog_app/bloc/blog_bloc.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BlogApp(),
  ));
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(), // Creating an instance of BlogBloc
      child: const HomeScreen(), // HomeScreen will now have access to BlogBloc
    );
  }
}

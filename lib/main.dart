import 'package:bloc_tutorial/UI/PostApiScreen/post_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Post Api",
      home: PostApiScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

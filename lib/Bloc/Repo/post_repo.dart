import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc_tutorial/Bloc/Models/PostModels/post_models.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  Future<List<PostModels>> fetchPost() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      );
      final body = json.decode(response.body) as List;
      if (response.statusCode == 200) {
        return body.map((dynamic a) {
          final b = a as Map<String, dynamic>;
          return PostModels(
            postId: b["postId"],
            id: b["id"],
            name: a["name"],
            body: a["body"],
            email: a["email"],
          );
        }).toList();
      }
    } on SocketException {
      Future.delayed(Duration(seconds: 3));
      throw Exception("Socket");
    } on TimeoutException {
      throw Exception("Time out");
    } on FormatException {
      throw Exception("Format Error");
    }
    throw Exception("Error");
  }
}

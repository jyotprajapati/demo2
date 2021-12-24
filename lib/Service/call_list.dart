import 'dart:convert';
import 'package:demo2/Model/post.dart';
import 'package:http/http.dart' as http;

class Posts {
  static Future<List<Post>> getPosts() async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

      var response = await http.get(url);

      final json = jsonDecode(response.body);

      List<Post> posts = [];

      (json as List).forEach((element) {
        posts.add(Post.fromJson(element));
      });
      // print(propertyNames);
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}

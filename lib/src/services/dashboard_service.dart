import 'dart:async';
import 'dart:io';

import 'package:harlequinsos/src/models/dasboard_model.dart';
import 'package:http/http.dart' as http;

String url =
    'https://harlequin-sos.com/harlequin_sos/harlequin_sos_slim/public/api/v1/uploadClientCords';

Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);
}

Future<Post> getPost() async {
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '',
      },
      body: postToJson(post));
  return response;
}

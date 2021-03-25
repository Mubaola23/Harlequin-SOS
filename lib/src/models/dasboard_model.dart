import 'dart:convert';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

List<Post> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

class Post {
  String client_id;
  String client_latitude;
  String client_longitude;
  String client_situation;
  String upload_use;
  String client_lga;

  Post(
      {this.upload_use,
      this.client_situation,
      this.client_longitude,
      this.client_latitude,
      this.client_id,
      this.client_lga});
  factory Post.fromJson(Map<String, dynamic> json) => Post(
      client_id: json['client_id'],
      client_latitude: json['client_latitude'],
      client_longitude: json["client_longitude"],
      client_situation: json["client_situation"],
      upload_use: json["upload_use"],
      client_lga: json["client_lga"]);

  Map<String, dynamic> toJson() => {
        "client_id": client_id,
        "client_latitude": client_latitude,
        "client_longitude": client_longitude,
        "client_situation": client_situation,
        "client_lga": client_lga,
        "upload_use": upload_use,
      };
}

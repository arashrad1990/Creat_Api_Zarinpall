import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/model.dart';

Future<List<posts>?> fatchposts() async {
  final responsee = await http.get(
    Uri.https("stokecom.ir", "/wp-json/wp/v2/posts/"),
    headers: {
      'Authorization': 'Basic YWRtaW46YTg2NjA1NzYwNTA0QEE=',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (responsee.statusCode == 200) {
    List<posts> listposts = List<posts>.from(
      jsonDecode(responsee.body).map((x) => posts.fromJson(x)),
    );
    return listposts;
  } else {
    throw Exception("not now red");
  }
}

Future<posts> sendpost(String title,String content) async {
  var url = "https://stokecom.ir/wp-json/wp/v2/posts";
  var responsee = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Basic YWRtaW46YTg2NjA1NzYwNTA0QEE=',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String >{
      'title': title,
      'content': content,
      'status': 'publish',
    }),
  );

  if (responsee.statusCode == 201) {
    return posts.fromJson(jsonDecode(responsee.body));
  } else {
    throw Exception(responsee.statusCode.toString());
  }
}

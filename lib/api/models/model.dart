
class posts {
  final int? id;
  final content? rendered;
  final String? date;

  posts({
    this.rendered,
    this.id,
    this.date,
  });

  factory posts.fromJson(Map<String, dynamic> json) {
    return posts(
        id: json['id'],
        date: json['date'],
        rendered: content.fromJson(json['content']));
  }
}

class content {
  final String? rendered;

  content({
    this.rendered,
  });

  factory content.fromJson(Map<String, dynamic> json) {
    return content(rendered: json['rendered']);
  }
  @override
  String toString() {
    return removeAllHtmlTags("${rendered}");
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

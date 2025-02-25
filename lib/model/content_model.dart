import 'package:html/parser.dart';

class ContentData {
  final String title;
  final String content;
  final String lastUpdated;

  ContentData({
    required this.title,
    required this.content,
    required this.lastUpdated,
  });

  factory ContentData.fromJson(Map<String, dynamic> json) {
    return ContentData(
      title: json['title'],
      content: _parseHtmlString(json['content']),
      lastUpdated: json['lastUpdated'],
    );
  }

  static String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    return document.body?.text ?? '';
  }
}

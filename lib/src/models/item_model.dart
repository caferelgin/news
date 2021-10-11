import 'dart:convert';

class ItemModel {
  final int id;
  final bool? deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool? dead;
  final int? parent;
  // final poll;
  final List<dynamic> kids;
  final String? url;
  final int? score;
  final String title;
  // final parts; // related to poll
  final int? descendants;

  toString() {
    return json.encode({
      'id': id,
      'deleted': deleted,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead,
      'parent': parent,
      'kids': kids,
      'url': url,
      'score': score,
      'descendants': descendants,
      'title': title
    });
  }

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'] ?? '',
        by = parsedJson['by'] ?? '',
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'] ?? '',
        score = parsedJson['score'],
        descendants = parsedJson['descendants'] ?? 0,
        title = parsedJson['title'] ?? '';

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = json.decode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        descendants = parsedJson['descendants'] ?? 0,
        title = parsedJson['title'] ?? '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deleted': deleted == null || deleted == false ? 0 : 1,
      'type': type,
      'by': by,
      'time': time,
      'text': text,
      'dead': dead == null || dead == false ? 0 : 1,
      'parent': parent,
      'kids': jsonEncode(kids),
      'url': url,
      'score': score,
      'descendants': descendants,
      'title': title
    };
  }
}

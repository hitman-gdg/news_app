import 'dart:convert';

class ItemModel {
  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = (parsedJson['type'] as String)?.toItem(),
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'] ?? 0,
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = ItemType.values[parsedJson['type']],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  final int id;
  final bool deleted;
  final ItemType type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  Map<String, dynamic> toMap() => {
      'id': id,
      'type': type?.index,
      'by': by,
      'time': time,
      'text': text,
      'parent': parent,
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants,
      'deleted': deleted ? 1 : 0,
      'dead': dead ? 1 : 0,
      'kids' : jsonEncode(kids),
    };
}

enum ItemType {
  job,
  story,
  comment,
  poll,
  pollopt,
}

extension on String {
  ItemType toItem() => ItemType.values.firstWhere(
      (e) => e.toString().toLowerCase() == 'itemtype.$this'.toLowerCase(),
      orElse: () => null);
}

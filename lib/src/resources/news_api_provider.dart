import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'repository.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  var client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_root/topstories.json');
    return json.decode(response.body).cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}

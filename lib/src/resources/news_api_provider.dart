import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import 'repository.dart';

class NewsApiProvider implements Source {
  Client client = Client();
  final _root = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    final ids = json.decode(response.body);

    // We need to cast int for the types obtained while decoding.
    // The compiler doesn't know the type
    return ids.cast<int>();
  }

  Future<ItemModel?> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}

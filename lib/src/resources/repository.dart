import 'dart:async';
import 'news_db_provider.dart';
import 'news_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  // NewsDbProvider dbProvider = NewsDbProvider();
  // NewsApiProvider apiProvider = NewsApiProvider();

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds(); // manivella to use NewsApiProvider Only!
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    var source;

    for (Source source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (source != cache) {
        if (item != null) {
          cache.addItem(item);
        }
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}

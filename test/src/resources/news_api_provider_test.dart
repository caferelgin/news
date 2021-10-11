import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';

void main() {
  test('FetchTopIds returns a list of top ids', () async {
    // setup of test case
    final newsApi = NewsApiProvider();

    // we are overriding the actual client with test client
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    // expectation
    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item model', () async {
    // setup of test case
    final newsApi = NewsApiProvider();

    // we are overriding the actual client with test client
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        "by": "pg",
        "descendants": 54,
        "id": 126809,
        "kids": [
          126822,
          126823,
          126993,
          126824,
          126934,
          127411,
          126888,
          127681,
          126818,
          126816,
          126854,
          127095,
          126861,
          127313,
          127299,
          126859,
          126852,
          126882,
          126832,
          127072,
          127217,
          126889,
          127535,
          126917,
          126875
        ],
        "parts": [126810, 126811, 126812],
        "score": 46,
        "text": "",
        "time": 1204403652,
        "title":
            "Poll: What would happen if News.YC had explicit support for polls?",
        "type": "poll"
      };
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    // expectation
    expect(item!.id, 126809);
  });
}

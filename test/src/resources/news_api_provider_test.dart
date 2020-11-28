import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/models/item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client =
        MockClient((_) async => Response(json.encode([1, 2, 3, 4]), 200));

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    final jsonMap = {'type': 'job'};
    newsApi.client =
        MockClient((_) async => Response(json.encode(jsonMap), 200));

    final item = await newsApi.fetchItem(999);

    expect(item.type, ItemType.job);
  });
}

import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  NewsListTile({this.itemId});

  final int itemId;

  build(context) {
    final bloc = StoriesProvider.of(context)..fetchItem(itemId);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        return !snapshot.hasData
            ? LoadingContainer()
            : FutureBuilder(
                future: snapshot.data[itemId],
                builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                  return !itemSnapshot.hasData
                      ? LoadingContainer()
                      : buildTile(context, itemSnapshot.data);
                },
              );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) => Column(
        children: [
          ListTile(
            title: Text(item.title),
            subtitle: Text('${item.score} points'),
            trailing: Column(
              children: [
                Icon(Icons.comment),
                Text('${item.descendants}'),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/${item.id}');
            },
          ),
          Divider(height: 8),
        ],
      );
}

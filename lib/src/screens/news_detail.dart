import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  NewsDetail({this.itemId});

  final int itemId;

  build(context) => Scaffold(
        appBar: AppBar(
          title: Text('Detail'),
        ),
        body: Text('$itemId'),
      );
}

import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  build(context) => Column(
    children: [
      ListTile(
        title: buildContainer(),
        subtitle: buildContainer(),
      ),
      Divider(height: 8),
    ],
  );

  Widget buildContainer() => Container(
    color: Colors.grey[200],
    height: 24,
    width: 150,
    margin: EdgeInsets.only(top: 5, bottom: 5),
  );
}

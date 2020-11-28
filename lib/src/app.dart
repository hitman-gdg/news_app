import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';
import 'screens/news_detail.dart';

class App extends StatelessWidget {
  build(context) => CommentsProvider(
        child: StoriesProvider(
          child: MaterialApp(
            title: 'News!',
            onGenerateRoute: routes,
          ),
        ),
      );

  Route routes(RouteSettings settings) => (settings.name ?? '/') == '/'
      ? MaterialPageRoute(builder: (context) => NewsList())
      : MaterialPageRoute(builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));
          commentsBloc?.fetchItemWithComments(itemId);
          return NewsDetail(itemId: itemId);
        });
}

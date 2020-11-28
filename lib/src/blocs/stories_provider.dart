import 'package:flutter/material.dart';
import 'stories_bloc.dart';

export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesProvider({Key key, Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  final StoriesBloc bloc;

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) =>
    context.dependOnInheritedWidgetOfExactType<StoriesProvider>().bloc;
}

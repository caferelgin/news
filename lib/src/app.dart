import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      // Make Stories Provider Available for all the app
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}

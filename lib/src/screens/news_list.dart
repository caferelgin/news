import 'package:flutter/material.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  build(context) {
    final bloc = StoriesProvider.of(context);

    // THIS IS BAD! DON'T DO THIS
    // TEMPORARY
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, int index) {
              // return Text('${snapshot.data![index]}');
              bloc.fetchItem(snapshot.data![index]);

              return NewsListTile(
                itemId: snapshot.data![index],
              );
            },
          );
        }
      },
    );
  }
}

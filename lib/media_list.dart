import 'package:church_app/picsum.dart';
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'media_detail.dart';

class MediaList extends StatelessWidget {
  const MediaList({Key key}) : super(key: key);

  void onListTileTap(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MediaDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media List"),
      ),
      body: ListView(
        children: List<ListTile>.generate(
          300,
          (index) => ListTile(
            leading: Image(image: NetworkImage(picsum("/200"))),
            title: Text(lipsum.createWord(numWords: 2)),
            subtitle: Text(lipsum.createSentence()),
            trailing: Icon(Icons.play_arrow),
            onTap: () => onListTileTap(context),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'media_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaList extends StatelessWidget {
  const MediaList({Key key}) : super(key: key);

  void onListTileTap(context, mediaItemId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MediaDetail(sermonId: mediaItemId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaItemsFuture = FirebaseFirestore.instance.collection('sermons').get();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sermons"),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: mediaItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: Text('Loading...'));
          }

          return ListView(
              children: snapshot.data.docs
                  .map(
                    (it) => ListTile(
                      leading: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: it.data()['thumbnailUrl'] ?? '',
                      ),
                      title: Text(it.data()['title'] ?? ''),
                      subtitle: Text(it.data()['author'] ?? ''),
                      trailing: Icon(Icons.play_arrow),
                      onTap: () => onListTileTap(context, it.id),
                    ),
                  )
                  .toList());
        },
      ),
    );
  }
}

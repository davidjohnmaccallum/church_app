import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'media_player.dart';
import 'models/Sermon.dart';

class SermonDetail extends StatelessWidget {
  final String sermonId;

  const SermonDetail({
    Key key,
    this.sermonId,
  }) : super(key: key);

  void onSharePressed() {
    print("MediaDetailState.onSharePressed()");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sermon>(
        future: Sermon.get(sermonId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            );
          }

          Sermon sermon = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text(sermon.title ?? ''),
              actions: [IconButton(icon: Icon(Icons.share), onPressed: onSharePressed)],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: sermon.imageUrl ?? '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sermon.title ?? '',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Text(sermon.description ?? ''),
                        MediaPlayer(
                          sermon: sermon,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

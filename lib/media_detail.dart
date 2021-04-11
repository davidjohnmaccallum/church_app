import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaDetail extends StatelessWidget {
  const MediaDetail({
    Key key,
    this.sermonId,
  }) : super(key: key);

  final String sermonId;

  void onSharePressed() {}

  @override
  Widget build(BuildContext context) {
    final sermonFuture = FirebaseFirestore.instance.collection('sermons').doc(sermonId).get();

    return FutureBuilder<DocumentSnapshot>(
        future: sermonFuture,
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

          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['title']),
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
                        image: snapshot.data['imageUrl'] ?? '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['title'] ?? '',
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Text(snapshot.data['description'] ?? ''),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.replay_10),
                                  iconSize: 40.0,
                                  onPressed: () => {},
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  iconSize: 60.0,
                                  onPressed: () => {},
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(Icons.forward_30),
                                  iconSize: 40.0,
                                  onPressed: () => {},
                                ),
                              ),
                              Expanded(
                                child: FlatButton(
                                  child: Text("1x"),
                                  onPressed: () => {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Slider(
                              value: 0.3,
                              onChanged: (d) => {},
                            ),
                            Positioned(
                              right: 16.0,
                              bottom: 0.0,
                              child: Text("0:00", style: Theme.of(context).textTheme.caption),
                            ),
                            Positioned(
                              left: 16.0,
                              bottom: 0.0,
                              child: Text("0:00", style: Theme.of(context).textTheme.caption),
                            ),
                          ],
                        )
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

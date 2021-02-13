import 'package:church_app/picsum.dart';
import 'package:flutter/material.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

class MediaDetail extends StatelessWidget {
  const MediaDetail({Key key}) : super(key: key);

  void onSharePressed() {}

  @override
  Widget build(BuildContext context) {
    final title = lipsum.createWord(numWords: 2);
    final detail = lipsum.createParagraph();
    final artUrl = picsum("/600/300");

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(icon: Icon(Icons.share), onPressed: onSharePressed)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: NetworkImage(artUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(detail),
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
                          child: Text("0:00",
                              style: Theme.of(context).textTheme.caption),
                        ),
                        Positioned(
                          left: 16.0,
                          bottom: 0.0,
                          child: Text("0:00",
                              style: Theme.of(context).textTheme.caption),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

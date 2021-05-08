import 'package:flutter/material.dart';

import 'header.dart';
import 'media_player/media_player.dart';

class SermonDetail extends StatelessWidget {
  final String title;
  final String titleImageUrl;
  final String description;

  const SermonDetail(
    this.title,
    this.titleImageUrl,
    this.description, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(title, titleImageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaPlayer(
                    state: MediaPlayerState.Stopped,
                    isPlaying: false,
                    playbackSpeed: 1.5,
                    length: Duration(seconds: 150),
                    position: Duration(seconds: 50),
                    seekToPosition: Duration(seconds: 100),
                    onChanged: (double value) => print("onChanged $value"),
                    onChangeStart: (double value) => print("onChangeStart $value"),
                    onChangeEnd: (double value) => print("onChangeEnd $value"),
                    start: () => print("start"),
                    onPlay: () => print("onPlay"),
                    onPause: () => print("onPause"),
                    onForward: () => print("onForward"),
                    onReplay: () => print("onReplay"),
                    onChangeSpeed: () => print("onChangeSpeed"),
                  ),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:church_app/media_player/media_player.dart';
import 'package:church_app/utils/picsum.dart';
import 'package:church_app/pages/sermon_detail.dart';
import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

import '../components/image_header.dart';

void main() {
  runApp(StoryboardApp([
    HeaderStory(),
    SermonDetailStory(),
    MediaPlayerStopped(),
    MediaPlayerLoading(),
    MediaPlayerPlaying(),
    MediaPlayerSeeking(),
    MediaPlayerBuffering(),
    MediaPlayerErrored(),
  ]));
}

class HeaderStory extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: ImageHeader(
          "Hello",
          picsumRandom("/600"),
        ),
      ),
    ];
  }
}

class SermonDetailStory extends FullScreenStory {
  @override
  List<Widget> get storyContent {
    return [
      SermonDetail("Hello", picsumRandom("/600"),
          "Ea id et est sint id. Reprehenderit do nulla esse cupidatat esse veniam aliquip cupidatat. Officia elit minim laboris in quis labore duis sunt eiusmod cupidatat amet minim minim."),
    ];
  }
}

class MediaPlayerStopped extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
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
      ),
    ];
  }
}

class MediaPlayerLoading extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
          state: MediaPlayerState.Loading,
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
      ),
    ];
  }
}

class MediaPlayerPlaying extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
          state: MediaPlayerState.Playing,
          isPlaying: false,
          playbackSpeed: 1.5,
          length: Duration(seconds: 150),
          position: Duration(seconds: 50),
          seekToPosition: Duration(seconds: 100),
          onChanged: (double value) => print("onChanged $value"),
          onChangeStart: (double value) => print("onChangeStart $value"),
          onChangeEnd: (double value) => print("onChangeEnd $value"),
          onPlay: () => print("onPlay"),
          onPause: () => print("onPause"),
          onForward: () => print("onForward"),
          onReplay: () => print("onReplay"),
          onChangeSpeed: () => print("onChangeSpeed"),
        ),
      ),
    ];
  }
}

class MediaPlayerSeeking extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
          state: MediaPlayerState.Seeking,
          isPlaying: false,
          playbackSpeed: 1.5,
          length: Duration(seconds: 150),
          position: Duration(seconds: 50),
          seekToPosition: Duration(seconds: 100),
          onChanged: (double value) => print("onChanged $value"),
          onChangeStart: (double value) => print("onChangeStart $value"),
          onChangeEnd: (double value) => print("onChangeEnd $value"),
          onPlay: () => print("onPlay"),
          onPause: () => print("onPause"),
          onForward: () => print("onForward"),
          onReplay: () => print("onReplay"),
          onChangeSpeed: () => print("onChangeSpeed"),
        ),
      ),
    ];
  }
}

class MediaPlayerBuffering extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
          state: MediaPlayerState.Buffering,
          isPlaying: false,
          playbackSpeed: 1.5,
          length: Duration(seconds: 150),
          position: Duration(seconds: 50),
          seekToPosition: Duration(seconds: 100),
          onChanged: (double value) => print("onChanged $value"),
          onChangeStart: (double value) => print("onChangeStart $value"),
          onChangeEnd: (double value) => print("onChangeEnd $value"),
          onPlay: () => print("onPlay"),
          onPause: () => print("onPause"),
          onForward: () => print("onForward"),
          onReplay: () => print("onReplay"),
          onChangeSpeed: () => print("onChangeSpeed"),
        ),
      ),
    ];
  }
}

class MediaPlayerErrored extends Story {
  @override
  List<Widget> get storyContent {
    return [
      SizedBox(
        width: 300,
        child: MediaPlayer(
          state: MediaPlayerState.Errored,
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
      ),
    ];
  }
}

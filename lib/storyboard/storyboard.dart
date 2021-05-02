import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

import 'media_player_stories.dart';

void main() {
  runApp(StoryboardApp([
    MediaPlayerStopped(),
    MediaPlayerLoading(),
    MediaPlayerPlaying(),
    MediaPlayerSeeking(),
    MediaPlayerBuffering(),
    MediaPlayerErrored(),
  ]));
}

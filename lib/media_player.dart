import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audio_player_task.dart';
import 'models/Sermon.dart';

_backgroundAudioTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class MediaPlayer extends StatefulWidget {
  final Sermon sermon;

  MediaPlayer({Key key, this.sermon}) : super(key: key);

  @override
  _MediaPlayerState createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  MediaItem mediaItem;
  PlaybackState playbackState;
  Duration position;
  bool isUserSeeking = false;
  double seekBarValue = 0.0;

  Future startBackgroundTask() async {
    print("startBackgroundTask");
    await AudioService.start(
      backgroundTaskEntrypoint: _backgroundAudioTaskEntrypoint,
      rewindInterval: Duration(seconds: 10),
      fastForwardInterval: Duration(seconds: 30),
    );

    AudioService.currentMediaItemStream.listen((MediaItem mediaItem) {
      if (isUserSeeking) return;
      print("currentMediaItemStream " + mediaItem.toString());
      setState(() {
        this.mediaItem = mediaItem;
      });
    });

    AudioService.playbackStateStream.listen((PlaybackState playbackState) {
      if (isUserSeeking) return;
      print("playbackStateStream " + playbackState.toString());
      setState(() {
        this.playbackState = playbackState;
      });
    });

    AudioService.positionStream.listen((Duration position) {
      if (isUserSeeking) return;
      print("positionStream " + position.toString());
      setState(() {
        this.position = position;
        if (position != null && mediaItem != null && mediaItem.duration != null) {
          seekBarValue = min(position.inMilliseconds / mediaItem.duration.inMilliseconds, 1);
        } else {
          seekBarValue = 0;
        }
      });
    });
  }

  Future startPlayback() async {
    print("startPlayback");
    AudioService.playMediaItem(
      MediaItem(
        id: widget.sermon.mediaUrl,
        album: widget.sermon.author,
        title: widget.sermon.title,
        artUri: widget.sermon.imageUrl,
      ),
    );
  }

  void onPlayPressed() async {
    print("onPlayPressed");
    if (!AudioService.running) {
      await startBackgroundTask();
    }
    if (playbackState == null ||
        playbackState.processingState == AudioProcessingState.none ||
        playbackState.processingState == AudioProcessingState.completed ||
        playbackState.processingState == AudioProcessingState.error) {
      await startPlayback();
    } else if (playbackState.playing) {
      await AudioService.pause();
    } else if (!playbackState.playing) {
      await AudioService.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  onPressed: () {
                    onPlayPressed();
                  },
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
                child: TextButton(
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
        ),
        Text("State: ${playbackState?.processingState}")
      ],
    );
  }
}

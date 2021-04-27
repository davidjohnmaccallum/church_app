import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'audio_player_task.dart';
import 'media_player_debug_info.dart';
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
  bool isUserSeeking = false;

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
        if (isCompleted(playbackState)) {
          AudioService.stop();
        }
      });
    });
  }

  bool isAudioNotLoaded(PlaybackState state) =>
      state == null ||
      state.processingState == AudioProcessingState.none ||
      state.processingState == AudioProcessingState.completed ||
      state.processingState == AudioProcessingState.error;

  bool isPlaying(PlaybackState state) => state != null && playbackState.playing;

  bool isCompleted(PlaybackState state) =>
      state != null && playbackState.processingState == AudioProcessingState.completed;

  Future loadAndPlay() async {
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

  void onPlayPausePressed() async {
    print("onPlayPausePressed");
    if (!AudioService.running) {
      await startBackgroundTask();
    }
    if (isAudioNotLoaded(playbackState)) {
      await loadAndPlay();
    } else if (isPlaying(playbackState)) {
      await AudioService.pause();
    } else if (!isPlaying(playbackState)) {
      await AudioService.play();
    }
  }

  void onSeekBarChanged(double value) {
    //print("onSeekBarChanged $value");
    // setState(() {
    //   seekBarValue = value;
    // });
  }

  void onSeekBarChangeStart(double value) {
    print("onSeekBarChangeStart $value");
    isUserSeeking = true;
  }

  void onSeekBarChangeEnd(double value) {
    print("onSeekBarChangeEnd $value");
    isUserSeeking = false;
    if (mediaItem == null || mediaItem.duration == null) return;
    num seekTo = mediaItem.duration.inMilliseconds * value;
    AudioService.seekTo(Duration(milliseconds: seekTo.round()));
  }

  String printPlayedTime(Duration position) {
    if (position == null) return "0:00";
    return printDuration(position);
  }

  String printRemainingTime(Duration position, MediaItem mediaItem) {
    if (position == null) return "0:00";
    if (mediaItem == null || mediaItem.duration == null) return "O:00";
    return printDuration(mediaItem.duration - position);
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inMinutes}:$twoDigitSeconds";
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
                  icon: Icon(isPlaying(playbackState) ? Icons.pause : Icons.play_arrow),
                  iconSize: 60.0,
                  onPressed: () {
                    onPlayPausePressed();
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
        buildSeekBar(context),
        MediaPlayerDebugInfo(
          //position: position,
          playbackState: playbackState,
          mediaItem: mediaItem,
        )
      ],
    );
  }

  // TODO: Position stream not updating after seeking.

  Widget buildSeekBar(BuildContext context) {
    return StreamBuilder(
      stream: AudioService.positionStream,
      builder: (context, snapshot) {
        Duration position = snapshot.data;
        double seekBarValue = 0.0;
        if (position != null && mediaItem != null && mediaItem.duration != null) {
          seekBarValue = min(position.inMilliseconds / mediaItem.duration.inMilliseconds, 1);
        } else {
          seekBarValue = 0;
        }

        return Stack(
          children: [
            Slider(
              value: seekBarValue,
              onChanged: onSeekBarChanged,
              onChangeStart: onSeekBarChangeStart,
              onChangeEnd: onSeekBarChangeEnd,
            ),
            Positioned(
              left: 16.0,
              bottom: 0.0,
              child: Text(printPlayedTime(snapshot.data), style: Theme.of(context).textTheme.caption),
            ),
            Positioned(
              right: 16.0,
              bottom: 0.0,
              child: Text(printRemainingTime(snapshot.data, mediaItem), style: Theme.of(context).textTheme.caption),
            ),
          ],
        );
      },
    );
  }
}

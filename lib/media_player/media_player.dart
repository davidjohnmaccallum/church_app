import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MediaPlayerState {
  Stopped,
  Loading,
  Buffering,
  Playing,
  Seeking,
  Errored,
}

class MediaPlayer extends StatelessWidget {
  final Duration position;
  final Duration length;
  final Duration seekToPosition;
  final bool isPlaying;
  final double playbackSpeed;
  final Function(double) onChanged;
  final Function(double) onChangeStart;
  final Function(double) onChangeEnd;
  final Function() start;
  final Function() onPlay;
  final Function() onPause;
  final Function() onForward;
  final Function() onReplay;
  final Function() onChangeSpeed;
  final MediaPlayerState state;

  MediaPlayer({
    Key key,
    this.position,
    this.length,
    this.seekToPosition,
    @required this.state,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.start,
    this.onPlay,
    this.onPause,
    this.onForward,
    this.onReplay,
    this.onChangeSpeed,
    @required this.isPlaying,
    @required this.playbackSpeed,
  }) : super(key: key);

  final _0_00 = "0:00";

  String printPlayedTime() {
    return {
          MediaPlayerState.Loading: _0_00,
          MediaPlayerState.Buffering: printDuration(position),
          MediaPlayerState.Playing: printDuration(position),
          MediaPlayerState.Seeking: printDuration(seekToPosition),
          MediaPlayerState.Errored: _0_00,
          MediaPlayerState.Stopped: printDuration(length),
        }[state] ??
        _0_00;
  }

  Duration diffDuration(Duration a, Duration b) {
    if (a == null || b == null) return Duration();
    return a - b;
  }

  String printRemainingTime() {
    return {
          MediaPlayerState.Loading: _0_00,
          MediaPlayerState.Buffering: printDuration(diffDuration(length, position)),
          MediaPlayerState.Playing: printDuration(diffDuration(length, position)),
          MediaPlayerState.Seeking: printDuration(diffDuration(length, seekToPosition)),
          MediaPlayerState.Errored: _0_00,
          MediaPlayerState.Stopped: printDuration(length),
        }[state] ??
        _0_00;
  }

  String printDuration(Duration duration) {
    if (duration == null) return _0_00;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  double getValue() {
    return {
          MediaPlayerState.Loading: 0.0,
          MediaPlayerState.Buffering: position?.inMilliseconds?.toDouble(),
          MediaPlayerState.Playing: position?.inMilliseconds?.toDouble(),
          MediaPlayerState.Seeking: seekToPosition?.inMilliseconds?.toDouble(),
          MediaPlayerState.Errored: 0.0,
          MediaPlayerState.Stopped: 0.0,
        }[state] ??
        0;
  }

  String getFeedback() {
    return {
          MediaPlayerState.Loading: "Loading...",
          MediaPlayerState.Buffering: "Buffering...",
          MediaPlayerState.Playing: "",
          MediaPlayerState.Seeking: "Buffering...",
          MediaPlayerState.Errored: "Error",
          MediaPlayerState.Stopped: "",
        }[state] ??
        "";
  }

  String getPlaybackSpeed() {
    var f = NumberFormat("###.#");
    return "${f.format(playbackSpeed)}x";
  }

  @override
  Widget build(BuildContext context) {
    return {
          MediaPlayerState.Stopped: buildStoppedPlayer(context),
          MediaPlayerState.Loading: buildLoadingPlayer(),
          MediaPlayerState.Playing: buildPlayingPlayer(context),
          MediaPlayerState.Buffering: buildBufferingPlayer(context),
          MediaPlayerState.Seeking: buildBufferingPlayer(context),
          MediaPlayerState.Errored: buildErroredPlayer(context),
        }[state] ??
        Container();
  }

  Widget buildStoppedPlayer(BuildContext context) {
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            iconSize: 60.0,
            onPressed: start,
          ),
        ],
      ),
    );
  }

  Widget buildLoadingPlayer() {
    return Container(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildPlayingPlayer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.replay_10),
              iconSize: 40.0,
              onPressed: onReplay,
            ),
            IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 60.0,
              onPressed: isPlaying ? onPause : onPlay,
            ),
            IconButton(
              icon: Icon(Icons.forward_30),
              iconSize: 40.0,
              onPressed: onForward,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(),
            TextButton(
              child: Text(getPlaybackSpeed()),
              onPressed: onChangeSpeed,
            ),
          ],
        ),
        Stack(
          children: [
            Slider(
              value: getValue(),
              max: length?.inMilliseconds?.toDouble() ?? 1,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
            Positioned(
              left: 16.0,
              bottom: 0.0,
              child: Text(
                printPlayedTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 0.0,
              child: Text(
                printRemainingTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBufferingPlayer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.replay_10),
              iconSize: 40.0,
              onPressed: onReplay,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            IconButton(
              icon: Icon(Icons.forward_30),
              iconSize: 40.0,
              onPressed: onForward,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Container(),
            TextButton(
              child: Text(getPlaybackSpeed()),
              onPressed: onChangeSpeed,
            ),
          ],
        ),
        Stack(
          children: [
            Slider(
              value: getValue(),
              max: length?.inMilliseconds?.toDouble() ?? 1,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
            Positioned(
              left: 16.0,
              bottom: 0.0,
              child: Text(
                printPlayedTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 0.0,
              child: Text(
                printRemainingTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildErroredPlayer(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 60.0,
              onPressed: start,
            ),
          ],
        ),
        Text(
          "Error",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}

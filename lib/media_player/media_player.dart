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

  String _printPlayedTime() {
    return {
          MediaPlayerState.Loading: _0_00,
          MediaPlayerState.Buffering: _printDuration(position),
          MediaPlayerState.Playing: _printDuration(position),
          MediaPlayerState.Seeking: _printDuration(seekToPosition),
          MediaPlayerState.Errored: _0_00,
          MediaPlayerState.Stopped: _printDuration(length),
        }[state] ??
        _0_00;
  }

  Duration _diffDuration(Duration a, Duration b) {
    if (a == null || b == null) return Duration();
    return a - b;
  }

  String _printRemainingTime() {
    return {
          MediaPlayerState.Loading: _0_00,
          MediaPlayerState.Buffering: _printDuration(_diffDuration(length, position)),
          MediaPlayerState.Playing: _printDuration(_diffDuration(length, position)),
          MediaPlayerState.Seeking: _printDuration(_diffDuration(length, seekToPosition)),
          MediaPlayerState.Errored: _0_00,
          MediaPlayerState.Stopped: _printDuration(length),
        }[state] ??
        _0_00;
  }

  String _printDuration(Duration duration) {
    if (duration == null) return _0_00;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  double _getValue() {
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

  String _getPlaybackSpeed() {
    var f = NumberFormat("###.#");
    return "${f.format(playbackSpeed)}x";
  }

  @override
  Widget build(BuildContext context) {
    var player = {
      MediaPlayerState.Stopped: _buildStoppedPlayer(context),
      MediaPlayerState.Loading: _buildLoadingPlayer(),
      MediaPlayerState.Playing: _buildPlayingPlayer(context),
      MediaPlayerState.Buffering: _buildBufferingPlayer(context),
      MediaPlayerState.Seeking: _buildBufferingPlayer(context),
      MediaPlayerState.Errored: _buildErroredPlayer(context),
    }[state];
    var height = {
      MediaPlayerState.Stopped: 65.0,
      MediaPlayerState.Loading: 65.0,
      MediaPlayerState.Playing: 172.0,
      MediaPlayerState.Buffering: 172.0,
      MediaPlayerState.Seeking: 172.0,
      MediaPlayerState.Errored: 93.0,
    }[state];
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: height,
      child: player,
    );
  }

  Widget _buildStoppedPlayer(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildLoadingPlayer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayingPlayer(BuildContext context) {
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
              child: Text(_getPlaybackSpeed()),
              onPressed: onChangeSpeed,
            ),
          ],
        ),
        Stack(
          children: [
            Slider(
              value: _getValue(),
              max: length?.inMilliseconds?.toDouble() ?? 1,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
            Positioned(
              left: 16.0,
              bottom: 0.0,
              child: Text(
                _printPlayedTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 0.0,
              child: Text(
                _printRemainingTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBufferingPlayer(BuildContext context) {
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
              child: Text(_getPlaybackSpeed()),
              onPressed: onChangeSpeed,
            ),
          ],
        ),
        Stack(
          children: [
            Slider(
              value: _getValue(),
              max: length?.inMilliseconds?.toDouble() ?? 1,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            ),
            Positioned(
              left: 16.0,
              bottom: 0.0,
              child: Text(
                _printPlayedTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 0.0,
              child: Text(
                _printRemainingTime(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErroredPlayer(BuildContext context) {
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

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class MediaPlayerDebugInfo extends StatelessWidget {
  final Duration position;
  final PlaybackState playbackState;
  final MediaItem mediaItem;

  const MediaPlayerDebugInfo({
    Key key,
    this.position,
    this.playbackState,
    this.mediaItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildCard(
        "Position",
        position != null ? ['$position'] : ["null"],
      ),
      buildCard(
        "Playback State",
        playbackState != null
            ? [
                'playing: ${playbackState.playing}',
                'bufferedPosition: ${playbackState.bufferedPosition}',
                'currentPosition: ${playbackState.currentPosition}',
                'position: ${playbackState.position}',
                'processingState: ${playbackState.processingState}',
                'repeatMode: ${playbackState.repeatMode}',
                'shuffleMode: ${playbackState.shuffleMode}',
                'speed: ${playbackState.speed}',
                'updateTime: ${playbackState.updateTime}',
              ]
            : ["null"],
      ),
      buildCard(
        "Media Item",
        mediaItem != null
            ? [
                'id: ${mediaItem.id}',
                'playable: ${mediaItem.playable}',
                'title: ${mediaItem.title}',
                'album: ${mediaItem.album}',
                'artist: ${mediaItem.artist}',
                'genre: ${mediaItem.genre}',
                'displayTitle: ${mediaItem.displayTitle}',
                'displaySubtitle: ${mediaItem.displaySubtitle}',
                'displayDescription: ${mediaItem.displayDescription}',
                'artUri: ${mediaItem.artUri}',
                'duration: ${mediaItem.duration}',
                'extras: ${mediaItem.extras}',
                'rating: ${mediaItem.rating}',
              ]
            : ["null"],
      ),
    ]);
  }

  Widget buildCard(String title, List<String> detail) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text(
                DateTime.now().toString(),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                detail.join("\n"),
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      );
}

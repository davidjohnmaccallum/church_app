import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();

  Map<ProcessingState, AudioProcessingState> stateMapping = {
    ProcessingState.idle: AudioProcessingState.none,
    ProcessingState.loading: AudioProcessingState.connecting,
    ProcessingState.buffering: AudioProcessingState.buffering,
    ProcessingState.ready: AudioProcessingState.ready,
    ProcessingState.completed: AudioProcessingState.completed,
  };

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    print("AudioPlayerTask.onStart");
    print(params);

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());

    // Listen to state changes on the player...
    _audioPlayer.playerStateStream.listen((PlayerState playerState) {
      print("PlayerState: ${playerState.processingState}");
      // ... and forward them to all audio_service clients.
      AudioServiceBackground.setState(
        speed: _audioPlayer.speed,
        playing: playerState.playing,
        // Every state from the audio player gets mapped onto an audio_service state.
        processingState: stateMapping[playerState.processingState],
        // Tell clients what buttons/controls should be enabled in the
        // current state.
        controls: [
          playerState.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.stop,
        ],
      );
    });
  }

  @override
  Future<void> onPlay() async {
    print("AudioPlayerTask.onPlay");
    _audioPlayer.play();
  }

  @override
  Future<void> onPlayMediaItem(MediaItem mediaItem) async {
    print("AudioPlayerTask.onPlayMediaItem");
    print(mediaItem);

    // Connect to the URL
    Duration duration = await _audioPlayer.setUrl(mediaItem.id);
    print("Duration $duration");

    await AudioServiceBackground.setMediaItem(mediaItem.copyWith(duration: duration));

    // Now we're ready to play
    _audioPlayer.play();
  }

  @override
  Future<void> onUpdateMediaItem(MediaItem mediaItem) async {
    print("AudioPlayerTask.onUpdateMediaItem");
    print(mediaItem);

    // Connect to the URL
    Duration duration = await _audioPlayer.setUrl(mediaItem.id);

    await AudioServiceBackground.setMediaItem(mediaItem.copyWith(duration: duration));
  }

  @override
  Future<void> onPause() async {
    print("AudioPlayerTask.onPause");
    await _audioPlayer.pause();
  }

  @override
  Future<void> onStop() async {
    print("AudioPlayerTask.onStop");
    await _audioPlayer.dispose();
    await super.onStop();
  }

  @override
  Future<void> onSeekTo(Duration position) async {
    print("AudioPlayerTask.onSeekTo $position");
    // TODO Broadcast buffering state
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> onFastForward() {
    final newPosition = _audioPlayer.position + fastForwardInterval;
    print("AudioPlayerTask.onFastForward $newPosition");
    // TODO Broadcast buffering state
    return _audioPlayer.seek(newPosition);
  }

  @override
  Future<void> onRewind() {
    final newPosition = _audioPlayer.position - rewindInterval;
    print("AudioPlayerTask.onRewind $newPosition");
    // TODO Broadcast buffering state
    return _audioPlayer.seek(newPosition);
  }
}

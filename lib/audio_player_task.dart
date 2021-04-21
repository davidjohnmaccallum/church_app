import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';

class AudioPlayerTask extends BackgroundAudioTask {
  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    print('AudioPlayerTask.onStart()');
    print(params);

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
  }
}

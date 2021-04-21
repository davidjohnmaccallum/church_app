import 'package:audio_service/audio_service.dart';
import 'package:church_app/media_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'audio_player_task.dart';
import 'media_detail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

_backgroundAudioTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AudioServiceWidget(
              child: snapshot.connectionState == ConnectionState.done
                  ? MediaList(onListTileTap: onListTileTap)
                  : Scaffold(body: Center(child: Text("Loading...")))),
        );
      },
    );
  }

  void onListTileTap(context, mediaItemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MediaDetail(
                sermonId: mediaItemId,
                onPlayPressed: onPlayPressed,
              )),
    );
  }

  void onPlayPressed() async {
    if (!AudioService.running) {
      bool res = await startAudioPlayerTask();
      if (!res) print('Audio service failed to start');
    }
  }

  Future<bool> startAudioPlayerTask() {
    return AudioService.start(
      backgroundTaskEntrypoint: _backgroundAudioTaskEntrypoint,
      rewindInterval: Duration(seconds: 10),
      fastForwardInterval: Duration(seconds: 30),
    );
  }
}

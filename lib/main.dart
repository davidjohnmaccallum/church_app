import 'package:audio_service/audio_service.dart';
import 'package:church_app/sermon_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'sermon_detail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
                  ? SermonList(onListTileTap: onListTileTap)
                  : Scaffold(body: Center(child: Text("Loading...")))),
        );
      },
    );
  }

  void onListTileTap(context, mediaItemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SermonDetail(
                sermonId: mediaItemId,
              )),
    );
  }
}

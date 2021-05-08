import 'package:audio_service/audio_service.dart';
import 'package:church_app/utils/picsum.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components/image_header_list.dart';
import 'pages/sermon_detail.dart';

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
          title: 'Church App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AudioServiceWidget(
            child: snapshot.connectionState == ConnectionState.done
                ? ImageHeaderList(
                    "",
                    picsumRandom("/600"),
                    [
                      ImageHeaderListModel(
                        "Hello",
                        "World",
                        picsumRandom("/600"),
                        onSeriesTap,
                      ),
                    ],
                  )
                : Scaffold(
                    body: Center(
                      child: Text("Loading..."),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void onSeriesTap(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageHeaderList(
          "Hello",
          picsumRandom("/600"),
          [
            ImageHeaderListModel("Hello", "World", picsumRandom("/600"), onSermonTap),
          ],
        ),
      ),
    );
  }

  void onSermonTap(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SermonDetail("Hello", picsumRandom("/600"),
                "Laborum duis irure et deserunt laboris. Amet sit ea esse ea. Minim magna eiusmod eu amet irure non est ex velit. Exercitation ut elit ullamco fugiat excepteur ea adipisicing occaecat aute. Aute sint sit sit proident.")));
  }
}

import 'dart:math';

import 'package:church_app/picsum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

void generate() {
  CollectionReference sermons =
      FirebaseFirestore.instance.collection('sermons');

  Future.wait(List<Future>.generate(300, (index) {
    final imageId = Random().nextInt(1000);
    return sermons.add({
      "_date": Timestamp.now(),
      "title": lipsum.createWord(numWords: 2),
      "author": "John Smith",
      "description": lipsum.createParagraph(),
      "imageUrl": picsum(imageId, "/600/300"),
      "thumbnailUrl": picsum(imageId, "/100"),
      "mediaUrl":
          "https://storage.googleapis.com/1a28da50-b6cc-11ea-9d3d-6b9876fb2fba/sermons/9wsi0SkYxPCc0b5ghuxc",
    });
  }))
      .then((value) => print("Media items generated"))
      .catchError((error) => print("Failed to generate media items: $error"));
}

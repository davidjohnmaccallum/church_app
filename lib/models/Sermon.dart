import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/utils.dart';

class Sermon {
  String id;
  DateTime date;
  String title;
  String author;
  String description;
  String imageUrl;
  String mediaUrl;
  String thumbnailUrl;

  static Stream<QuerySnapshot> stream() {
    CollectionReference collection = FirebaseFirestore.instance.collection('sermons');
    return collection.snapshots();
  }

  static Stream<QuerySnapshot> search(String query) {
    CollectionReference collection = FirebaseFirestore.instance.collection('sermons');
    return collection.where('title', isEqualTo: query).get().asStream();
  }

  static Future<Sermon> get(String id) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('sermons');
    DocumentSnapshot snapshot = await collection.doc(id).get();
    return fromDocument(snapshot);
  }

  Future<void> save() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('sermons');
    if (this.id != null) {
      await collection.doc(this.id).set(_toDocument(this));
    } else {
      await collection.add(_toDocument(this));
    }
  }

  static Sermon Function(DocumentSnapshot) fromDocument = (DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data();
    Sermon result = new Sermon();
    result.id = doc.id;
    result.date = parseTimestamp(data['_date']);
    result.title = data['title'];
    result.author = data['author'];
    result.description = data['description'];
    result.imageUrl = data['imageUrl'];
    result.mediaUrl = data['mediaUrl'];
    result.thumbnailUrl = data['thumbnailUrl'];
    return result;
  };

  static Map<String, dynamic> _toDocument(Sermon sermon) {
    Map<String, dynamic> result = Map<String, dynamic>();
    result['id'] = sermon.id;
    result['_date'] = Timestamp.fromDate(sermon.date);
    result['title'] = sermon.title;
    result['author'] = sermon.author;
    result['description'] = sermon.description;
    result['imageUrl'] = sermon.imageUrl;
    result['mediaUrl'] = sermon.mediaUrl;
    result['thumbnailUrl'] = sermon.thumbnailUrl;
    return result;
  }
}

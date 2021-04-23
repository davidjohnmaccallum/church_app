import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime parseTimestamp(Timestamp t) {
  if (t == null) return null;
  if (t is! Timestamp) return null;
  return t.toDate();
}

String formatDateTime(DateTime dt) {
  if (dt == null) return null;
  return DateFormat('yyyy-MM-dd').format(dt);
}

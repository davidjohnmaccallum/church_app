import 'dart:math';

String picsum(String path) {
  final id = Random().nextInt(1000);
  return "https://picsum.photos/id/$id$path";
}

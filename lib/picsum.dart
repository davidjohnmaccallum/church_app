import 'dart:math';

String picsumRandom(String path) {
  final imageId = Random().nextInt(1000);
  return "https://picsum.photos/id/$imageId$path";
}

String picsum(int imageId, String path) {
  return "https://picsum.photos/id/$imageId$path";
}

import 'package:church_app/picsum.dart';
import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

import '../header_list.dart';

void main() {
  runApp(StoryboardApp([
    SeriesListStory(),
  ]));
}

class SeriesListStory extends FullScreenStory {
  @override
  List<Widget> get storyContent {
    return [
      HeaderList(
        "Hello",
        picsumRandom("/600"),
        List<HeaderListModel>.filled(3, HeaderListModel("Hello", "World", picsumRandom("/200"), () {})),
      ),
    ];
  }
}

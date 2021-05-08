import 'package:church_app/picsum.dart';
import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';

import '../series_list.dart';

void main() {
  runApp(StoryboardApp([
    SeriesListStory(),
  ]));
}

class SeriesListStory extends FullScreenStory {
  @override
  List<Widget> get storyContent {
    return [
      SeriesList(
        "Hello",
        picsumRandom("/600"),
        List<SeriesListModel>.filled(3, SeriesListModel("Hello", "World", picsumRandom("/200"), () {})),
      ),
    ];
  }
}

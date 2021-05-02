// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:church_app/media_player/media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

wrapInApp(Widget widget) => MaterialApp(home: Scaffold(body: widget));

void main() {
  testWidgets('State when Loading', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Loading,
    )));
    expect(find.text('0:00'), findsNWidgets(2));
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('State when Playing', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Playing,
      length: Duration(seconds: 60),
      position: Duration(seconds: 20),
    )));
    expect(find.text('0:20'), findsOneWidget);
    expect(find.text('0:40'), findsOneWidget);
  });

  testWidgets('State when Seeking', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Seeking,
      length: Duration(seconds: 60),
      seekToPosition: Duration(seconds: 10),
    )));
    expect(find.text('0:10'), findsOneWidget);
    expect(find.text('0:50'), findsOneWidget);
    expect(find.text('Buffering...'), findsOneWidget);
  });

  testWidgets('State when Buffering', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Buffering,
      length: Duration(seconds: 60),
      position: Duration(seconds: 10),
    )));
    expect(find.text('0:10'), findsOneWidget);
    expect(find.text('0:50'), findsOneWidget);
    expect(find.text('Buffering...'), findsOneWidget);
  });

  testWidgets('State when Errored', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Errored,
    )));
    expect(find.text('0:00'), findsNWidgets(2));
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('State when Finished', (WidgetTester tester) async {
    await tester.pumpWidget(wrapInApp(MediaPlayer(
      state: MediaPlayerState.Finished,
      length: Duration(seconds: 60),
    )));
    expect(find.text('1:00'), findsNWidgets(2));
  });
}

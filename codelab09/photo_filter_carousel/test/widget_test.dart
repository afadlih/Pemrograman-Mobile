// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:photo_filter_carousel/widget/filter_carousel.dart';

void main() {
  testWidgets('Photo filter carousel smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: PhotoFilterCarousel()));

    // Verify that PhotoFilterCarousel widget is displayed
    expect(find.byType(PhotoFilterCarousel), findsOneWidget);

    // Wait for image to load
    await tester.pumpAndSettle();
  });
}

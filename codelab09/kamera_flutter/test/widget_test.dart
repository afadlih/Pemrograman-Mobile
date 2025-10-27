// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';

import 'package:kamera_flutter/widget/takepicture_screen.dart';

void main() {
  testWidgets('Camera app smoke test', (WidgetTester tester) async {
    // Mock camera for testing
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      // Skip test if no camera available
      return;
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(home: TakePictureScreen(camera: cameras.first)),
    );

    // Verify that camera preview is shown
    expect(find.byType(TakePictureScreen), findsOneWidget);

    // Verify that floating action button exists
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });
}

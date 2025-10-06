// ignore_for_file: avoid_relative_lib_imports
// Widget test untuk memastikan layout wisata dan komponen utama muncul.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Memuat layout wisata dengan ikon dan review', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('Wisata Gunung'), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    expect(find.text('41'), findsOneWidget);
  });
}

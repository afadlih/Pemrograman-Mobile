// ignore_for_file: avoid_relative_lib_imports
// Widget test untuk memastikan layout utama dan identitas ditampilkan.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Memuat layout pavlova dan identitas tampil', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.textContaining('Strawberry Pavlova'), findsOneWidget);
    expect(find.textContaining('Ahmad Fadlih Wahyu Sardana'), findsOneWidget);
    // Pastikan ada lima ikon bintang
    expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));
  });
}

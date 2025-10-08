import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/item_page.dart';
import 'models/item.dart';
import 'identity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belanja App - $studentName',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 1.5,
          margin: EdgeInsets.zero,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/item': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Item;
          return ItemPage(item: args);
        },
      },
    );
  }
}

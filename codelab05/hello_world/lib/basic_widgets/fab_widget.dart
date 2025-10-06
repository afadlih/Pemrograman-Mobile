import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAB Demo')),
      body: const Center(
        child: Text(
          'Floating Action Button Contoh\nAhmad Fadlih Wahyu Sardana (2341720069 / 03)',
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: const Icon(Icons.thumb_up),
      ),
    );
  }
}

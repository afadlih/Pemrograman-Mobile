import 'package:flutter/material.dart';
import '../models/item.dart';
import '../identity.dart';

class ItemPage extends StatelessWidget {
  final Item item;
  const ItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: item.name,
                child: Image.asset(item.photo, height: 200),
              ),
            ),
            SizedBox(height: 16),
            Text(
              item.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              studentIdentityLine,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rp ${item.price}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stok tersedia: ${item.stock}'),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(item.rating.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item.name} ditambahkan ke keranjang'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          icon: Icon(Icons.add_shopping_cart),
          label: Text('Tambah ke Keranjang'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

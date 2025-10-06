import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const identity = 'Ahmad Fadlih Wahyu Sardana | 2341720069 | 03';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Layout Demo'),
          centerTitle: true,
        ),
        body: const _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        _HeroImage(),
        _TitleSection(),
        SizedBox(height: 8),
        _ButtonRow(),
        _DescriptionSection(),
        SizedBox(height: 24),
        _IdentityCard(),
        SizedBox(height: 24),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: Image.asset(
        'images/view_gunung.jpg',
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wisata Gunung di Batu',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Batu, Malang, Indonesia',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, color: Colors.red, size: 28),
          const SizedBox(width: 4),
          Text('41', style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _ButtonRow extends StatelessWidget {
  const _ButtonRow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _ActionButton(icon: Icons.call, label: 'CALL'),
          _ActionButton(icon: Icons.near_me, label: 'ROUTE'),
          _ActionButton(icon: Icons.share, label: 'SHARE'),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionButton({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Carilah teks di internet yang sesuai dengan foto atau tempat wisata yang ingin Anda tampilkan.\n'
        'Tambahkan nama dan NIM Anda sebagai identitas hasil pekerjaan Anda.\nSelamat mengerjakan 🙂.',
        softWrap: true,
        style: const TextStyle(height: 1.4),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          child: Text(
            'Ahmad Fadlih Wahyu Sardana\nNIM 2341720069 | No 03',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

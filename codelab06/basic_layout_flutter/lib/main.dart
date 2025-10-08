import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Identity & description dipakai di _MainContent (dipusatkan di sana untuk menghindari duplikasi).

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Strawberry Pavlova'),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;
            final content = _MainContent(isWide: isWide);
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: content,
            );
          },
        ),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({required this.isWide});
  final bool isWide;

  static const _identity = 'Ahmad Fadlih Wahyu Sardana\nNIM 2341720069 | No 03';
  static const _description =
      'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. '
      'It has a crisp crust and soft, light inside, topped with fruit and whipped cream.';

  @override
  Widget build(BuildContext context) {
    final infoCard = Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _identity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              _description,
              textAlign: TextAlign.center,
              style: TextStyle(height: 1.4),
              softWrap: true,
            ),
            const SizedBox(height: 20),
            _RatingAndStats(),
          ],
        ),
      ),
    );

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'images/cake.jpg',
        height: 260,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: infoCard),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(16), child: image),
          ),
        ],
      );
    }
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      children: [image, infoCard],
    );
  }
}

class _RatingAndStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Colors.red.shade400;
    // statStyle dihapus karena tidak terpakai (disederhanakan untuk desain minimalis).
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Icon(Icons.star_rounded, color: color, size: 20),
            const SizedBox(width: 8),
            const Text('170 Reviews'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _MiniStat(icon: Icons.kitchen, label: 'PREP', value: '25 min'),
            _MiniStat(icon: Icons.timer, label: 'COOK', value: '1 hr'),
            _MiniStat(icon: Icons.restaurant, label: 'FEEDS', value: '4-6'),
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.green.shade600;
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
        Text(value, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

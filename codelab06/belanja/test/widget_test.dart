// ignore_for_file: avoid_relative_lib_imports
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';

void main() {
  testWidgets('Grid produk muncul & navigasi ke detail berhasil', (
    tester,
  ) async {
    await tester.pumpWidget(MyApp());

    // Pastikan judul appBar tampil
    expect(find.text('Belanja'), findsOneWidget);

    // Biarkan semua frame selesai (misal gambar / grid build)
    await tester.pumpAndSettle();

    // Ambil salah satu item berdasarkan teks produk (misal Sugar)
    final sugarFinder = find.text('Sugar');
    expect(
      sugarFinder,
      findsOneWidget,
      reason: 'Produk Sugar harus tampil di grid',
    );

    // Tap untuk navigasi ke halaman detail
    await tester.tap(sugarFinder);
    await tester.pumpAndSettle();

    // Halaman detail harus menampilkan nama produk & identitas mahasiswa
    expect(find.text('Sugar'), findsOneWidget);
    expect(find.textContaining('Ahmad Fadlih Wahyu Sardana'), findsOneWidget);
  });
}

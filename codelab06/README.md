
title: 'Flutter layout: Ahmad Fadlih Wahyu Sardana - 2341720069',
# Codelab 06 – Flutter Layout & Belanja App

## Identitas
Nama: **Ahmad Fadlih Wahyu Sardana**  
NIM: **2341720069**  
No Absen: **03**  
Kelas: **TI-3F**  

---

## Daftar Isi
1. Ringkasan & Proyek
2. Praktikum Layout (1–4)
3. Praktikum 5 (Navigasi) & Belanja App
4. Tugas Lanjutan (Grid, Hero, SnackBar)
5. Struktur Folder Codelab
6. Potongan Kode Inti
7. Catatan & Pengembangan Lanjut

---

## 1. Ringkasan & Proyek
Codelab ini mencakup tiga mini–project:

| Proyek | Tujuan | File Utama |
|--------|--------|------------|
| `layout_flutter` | Latihan membangun layout statis (gambar, title section, buttons, deskripsi) | `lib/main.dart` |
| `basic_layout_flutter` | Versi layout dengan refactor responsif & styling modern | `lib/main.dart` |
| `belanja` | Aplikasi katalog produk sederhana (grid → detail) dengan navigasi & animasi | `lib/main.dart`, `pages/`, `models/` |

Identitas ditampilkan di setiap aplikasi untuk kejelasan kepemilikan.

---

## 2. Praktikum Layout (1–4)
Fokus: memecah UI menjadi bagian kecil, memahami Row, Column, Expanded, padding, alignment.

Langkah ringkas implementasi `layout_flutter`:
1. Tambah gambar (hero image) `Image.asset('images/view_gunung.jpg')`.
2. Title section: Row → Expanded → Column (judul + lokasi) + ikon bintang + angka review.
3. Tombol aksi: deretan tiga ikon (CALL / ROUTE / SHARE) menggunakan Row + Column kecil.
4. Deskripsi: Text panjang dengan `softWrap: true` + padding.
5. Refactor di versi lanjutan (`basic_layout_flutter`) menjadi komponen kecil + responsive + card identitas.

Contoh Title Section (disederhanakan):
```dart
Row(
    children: [
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text('Wisata Gunung di Batu', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Batu, Malang, Indonesia', style: TextStyle(color: Colors.grey[600])),
                ],
            ),
        ),
        const Icon(Icons.star_rounded, color: Colors.red),
        const SizedBox(width: 4),
        const Text('41'),
    ],
)
```

---

## 3. Praktikum 5 (Navigasi) & Belanja App
`belanja` menampilkan daftar produk dalam Grid → menuju halaman detail.

Fitur aktif saat ini:
- Grid produk (nama, harga, rating).
- Hero animation gambar produk.
- Navigasi `Navigator.pushNamed` + arguments.
- Detail menampilkan identitas mahasiswa.
- SnackBar saat menambah ke keranjang (simulasi).

Rute dasar:
```dart
MaterialApp(
    initialRoute: '/',
    routes: {
        '/': (_) => HomePage(),
        '/item': (ctx) {
            final item = ModalRoute.of(ctx)!.settings.arguments as Item;
            return ItemPage(item: item);
        },
    },
);
```

Kirim data ke detail:
```dart
Navigator.pushNamed(context, '/item', arguments: item);
```

Hero pada kartu:
```dart
Hero(tag: item.name, child: Image.asset(item.photo, fit: BoxFit.cover));
```

SnackBar aksi sederhana:
```dart
ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('${item.name} ditambahkan ke keranjang')),
);
```

---

## 4. Tugas Lanjutan (Sudah / Potensial)
- [x] GridView + rating + stok.
- [x] Hero animation.
- [x] Refactor widget menjadi komponen kecil (`_ItemCard`).
- [x] Identitas terpusat (`identity.dart`).
- [ ] Tambah pencarian / filter.
- [ ] Keranjang dengan state management.
- [ ] Dark mode toggle.

---

## 5. Struktur Folder Codelab
```
codelab06/
    basic_layout_flutter/
        lib/main.dart
    layout_flutter/
        lib/main.dart
    belanja/
        lib/
            main.dart
            identity.dart
            models/item.dart
            pages/home_page.dart
            pages/item_page.dart
```

---

## 6. Potongan Kode Inti
Model Item:
```dart
class Item {
    String name;
    int price;
    String photo;
    int stock;
    double rating;
    Item({required this.name, required this.price, required this.photo, required this.stock, required this.rating});
}
```

Identity (terpusat di `identity.dart`):
```dart
const studentName = 'Ahmad Fadlih Wahyu Sardana';
const studentNim = '2341720069';
const studentNo = '03';
const studentIdentityLine = '$studentName | $studentNim | $studentNo';
```

Mini stat (layout Pavlova variant):
```dart
class _MiniStat extends StatelessWidget {
    final IconData icon; final String label; final String value;
    const _MiniStat({required this.icon, required this.label, required this.value});
    @override Widget build(BuildContext ctx) => Column(children:[
        Icon(icon, color: Colors.green.shade600),
        const SizedBox(height:4),
        Text(label, style: TextStyle(fontSize:12, color: Colors.green.shade600)),
        Text(value, style: const TextStyle(fontSize:12)),
    ]);
}
```

Kartu produk ringkas:
```dart
class _ItemCard extends StatelessWidget {
    final Item item; final VoidCallback onTap;
    const _ItemCard({required this.item, required this.onTap});
    @override Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(16), onTap: onTap,
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children:[
                Expanded(child: Hero(tag:item.name, child: Image.asset(item.photo, fit:BoxFit.cover, width:double.infinity))),
                Padding(padding: const EdgeInsets.all(10), child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[ Text('Rp ${item.price}', style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w600)),
                        Row(children:[const Icon(Icons.star_rounded,color:Colors.orange,size:16), const SizedBox(width:4), Text(item.rating.toString())]) ]))
            ]),
        ),
    );
}
```

---

## 7. Catatan & Pengembangan Lanjut
- Gunakan konsistensi warna melalui `ColorScheme.fromSeed` (sudah diterapkan).
- Hindari duplikasi identitas di banyak file → sudah dipusatkan.
- Bisa tambah: pencarian produk, filter rating, persistent favorites, dark mode toggle.
- Dokumentasi difokuskan ke kode (gambar hanya pelengkap bila tersedia).

---

## 8. Testing (Widget Tests)
Tiga proyek memiliki widget test dasar untuk memverifikasi UI utama dan identitas.

| Proyek | File Test | Fokus Verifikasi |
|--------|-----------|------------------|
| basic_layout_flutter | `test/widget_test.dart` | Teks Pavlova + identitas + ikon bintang (5x) |
| layout_flutter | `test/widget_test.dart` | Judul wisata, ikon bintang tunggal, jumlah review |
| belanja | `test/widget_test.dart` | Grid muncul, produk 'Sugar' dapat ditekan, navigasi ke detail + identitas |

Menjalankan semua test (dalam masing-masing folder proyek):

```bash
flutter test
```
Karena struktur multi-app di dalam satu repo, jalankan per folder (masuk ke direktori aplikasinya dulu) agar dependency benar.

Catatan:

- Relative import pada test (`../lib/main.dart`) diberi komentar `ignore_for_file` untuk menghindari lint karena setiap app berdiri mandiri di subfolder.
- Test belanja memanfaatkan `pumpAndSettle()` untuk menunggu animasi / build grid.
- Jika menambah fitur (misal pencarian), buat test baru: filter kata kunci → pastikan item grid berkurang.

Contoh pola test navigasi singkat:

```dart
await tester.tap(find.text('Sugar'));
await tester.pumpAndSettle();
expect(find.text('Sugar'), findsOneWidget); // di halaman detail
```


---

## Belanja App – Codelab 06

Identitas:
- Nama: **Ahmad Fadlih Wahyu Sardana**
- NIM: **2341720069**
- No: **03**
- Kelas: **TI-3F**

---

### Ringkasan
Aplikasi katalog belanja sederhana yang menampilkan daftar barang (grid), detail barang (halaman terpisah), dan interaksi sederhana (navigasi + notifikasi SnackBar saat menambah item ke keranjang – simulasi).

### Fitur Utama
- Grid produk responsif sederhana
- Hero animation (gambar dari daftar ke detail)
- Model data terstruktur (`Item`)
- Navigasi antar halaman (`Navigator` + named routes)
- Identitas dinamis terpusat (`identity.dart`)

### Struktur Folder Penting
```
lib/
	main.dart            # Entry point + route map
	identity.dart        # Konstanta identitas terpusat
	models/
		item.dart          # Model data Item
	pages/
		home_page.dart     # Grid produk
		item_page.dart     # Detail produk + tombol
```

### Cuplikan Model
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

### Navigasi (Named Routes)
```dart
MaterialApp(
	initialRoute: '/',
	routes: {
		'/': (_) => HomePage(),
		'/item': (context) {
			final args = ModalRoute.of(context)!.settings.arguments as Item;
			return ItemPage(item: args);
		},
	},
);
```

### Mengirim Item ke Halaman Detail
```dart
Navigator.pushNamed(context, '/item', arguments: item);
```

### Hero Transition
```dart
Hero(
	tag: item.name,
	child: Image.asset(item.photo, fit: BoxFit.cover),
)
```

### SnackBar Aksi
```dart
ScaffoldMessenger.of(context).showSnackBar(
	SnackBar(content: Text('${item.name} ditambahkan ke keranjang')),
);
```

### Identitas Terpusat
```dart
// identity.dart
const studentIdentityLine = 'Ahmad Fadlih Wahyu Sardana | 2341720069 | 03';
```

### Cara Menjalankan
```bash
flutter pub get
flutter run -d chrome    # atau emulator/device lain
```

### Pengembangan Lanjutan (Opsional)
- Filter/pencarian produk
- State manajemen (Provider / Riverpod) untuk keranjang
- Format harga (intl)
- Persistensi (shared_preferences / hive)

---
Selesai. Dokumentasi selaras dengan kode terkini.

# Codelab 05 – Flutter Fundamental (Part 1)

## Identitas
- Nama: **Ahmad Fadlih Wahyu Sardana**  
- NIM: **2341720069**  
- Kelas: **TI-3F**  
- No Absen: **03**

---

## Daftar Isi
1. [Praktikum 1 – Membuat Project Flutter Baru](#praktikum-1--membuat-project-flutter-baru)  
2. [Praktikum 2 – Menjalankan di Perangkat Fisik / Emulator](#praktikum-2--menjalankan-di-perangkat-fisik--emulator)  
3. [Praktikum 3 – Git & GitHub + Dokumentasi](#praktikum-3--git--github--dokumentasi)  
4. [Praktikum 4 – Widget Dasar](#praktikum-4--widget-dasar)  
5. [Praktikum 5 – Material & Cupertino Widgets](#praktikum-5--material--cupertino-widgets)  
6. [Tugas Tambahan – Namer App](#tugas-tambahan--namer-app)  
7. [Struktur Folder](#struktur-folder)  
8. [Potongan Kode Penting](#potongan-kode-penting)  
9. [Konfigurasi Aset](#konfigurasi-aset)  
10. [Catatan](#catatan)  

---

## Praktikum 1 – Membuat Project Flutter Baru
Langkah:
1. Buka VS Code → Ctrl + Shift + P → ketik "Flutter" → pilih "New Application Project".  
2. Pilih folder kerja.  
3. Masukkan nama: `hello_world`.  
4. Setelah selesai muncul pesan: "Your Flutter Project is ready!".  
Karena beberapa gambar langkah tidak tersedia / hilang, berikut ringkasan alternatif berbasis perintah:

```bash
# (Opsional) Membuat project lewat CLI
flutter create hello_world

# Masuk ke folder
cd hello_world

# Membuka di VS Code (bila pakai terminal)
code .
```

Struktur awal penting (disederhanakan):
```
hello_world/
  lib/
    main.dart        <- Titik masuk aplikasi
  pubspec.yaml       <- Konfigurasi dependencies & assets
```

---

## Praktikum 2 – Menjalankan di Perangkat Fisik / Emulator
Pastikan device terdeteksi (`flutter devices`). Jalankan:  
```
flutter run
```
Contoh output ringkas (tergantung versi SDK):
```
Launching lib/main.dart on sdk gphone64 x86 64 in debug mode...
Running Gradle task 'assembleDebug'... (xx.xs)
✓  Built build/app/outputs/flutter-apk/app-debug.apk.
Installing build/app/outputs/flutter-apk/app-debug.apk... (xxms)
Debug service listening on ws://127.0.0.1:<port>/xxxx=
Syncing files to device sdk gphone64 x86 64... (xxms)
```

---

## Praktikum 3 – Git & GitHub + Dokumentasi
Ringkas alur:
1. Buat repo GitHub: `flutter-fundamental-part1`.  
2. Inisialisasi di project:
  ```
  git init
  git remote add origin <url>
  git add .gitignore
  git commit -m "tambah gitignore"
  git push -u origin main
  ```
3. Tambah & commit `README.md`.  
4. Stage & push seluruh file project:  
  ```
  git add .
  git commit -m "project hello_world"
  git push
  ```
5. Jalankan aplikasi, ubah text menjadi nama lengkap, screenshot → simpan `images/01.png`.  
berikut contoh perubahan pada `lib/main.dart` yang menampilkan identitas:

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello World')), 
      body: const Center(
        child: Text(
          'Ahmad Fadlih Wahyu Sardana\nNIM 2341720069',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
```

Langkah dokumentasi: setiap perubahan penting → `git add .` → `git commit -m "deskripsi"` → `git push`.

---

## Praktikum 4 – Widget Dasar

### 1. Text Widget
`text_widget.dart` menampilkan teks dengan gaya khusus. Karena gambar tidak lengkap, berikut potongan ringkas gaya kontainer yang dipakai:

```dart
Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
    borderRadius: BorderRadius.circular(16),
  ),
  child: const Text(
    'Belajar Flutter: Ahmad Fadlih Wahyu Sardana\nNIM 2341720069',
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
)
```

### 2. Image Widget
Menampilkan aset lokal. Contoh pemanggilan:

```dart
const Image(image: AssetImage('logo_polinema.jpg'), width: 160);
```

---

## Praktikum 5 – Material & Cupertino Widgets

### 1. Cupertino Button & Loading
```dart
CupertinoButton(
  color: CupertinoColors.activeBlue,
  onPressed: () {},
  child: const Text('Proses'),
);
const CupertinoActivityIndicator();
```

### 2. Floating Action Button
```dart
FloatingActionButton(
  onPressed: increment,
  child: const Icon(Icons.add),
);
```

### 3. Scaffold + FAB + Counter
```dart
Scaffold(
  appBar: AppBar(title: const Text('Counter')),
  floatingActionButton: FloatingActionButton(onPressed: increment, child: const Icon(Icons.add)),
  body: Center(child: Text('Count: $value')),
);
```

### 4. Dialog (AlertDialog)
```dart
showDialog(
  context: context,
  builder: (c) => AlertDialog(
    title: const Text('Konfirmasi'),
    content: const Text('Lanjutkan proses?'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(c), child: const Text('Batal')),
      FilledButton(onPressed: () {}, child: const Text('OK')),
    ],
  ),
);
```

### 5. Input (TextField)
```dart
TextField(
  controller: nameCtrl,
  decoration: const InputDecoration(
    labelText: 'Nama Lengkap',
    prefixIcon: Icon(Icons.person_outline),
    border: OutlineInputBorder(),
  ),
)
```

### 6. Date Picker
```dart
final picked = await showDatePicker(
  context: context,
  initialDate: selected,
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
);
if (picked != null) setState(() => selected = picked);
```

---

## Tugas Tambahan – Namer App
Hasil modifikasi codelab (favorit, navigasi, identitas ditampilkan) – gambar tidak tersedia sehingga diganti cuplikan kode inti.

State management memakai Provider:
```dart
class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random();
  final favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
```

Widget kartu kata dengan animasi:
```dart
class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});
  final WordPair pair;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineLarge!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}
```

Halaman profil menampilkan identitas (Nama, NIM, No Absen) dalam kartu bergaya.

---

## Struktur Folder
```
lib/
  main.dart
  basic_widgets/
   text_widget.dart
   image_widget.dart
   loading_cupertino.dart
   fab_widget.dart
   scaffold_example.dart
   dialog_example.dart
   input_example.dart
   date_picker_example.dart
```

---

## Potongan Kode Penting

Text Widget:
```dart
class MyTextWidget extends StatelessWidget {
  const MyTextWidget({super.key});
  @override
  Widget build(BuildContext context) {
   return const Text(
    'Nama saya Ahmad Fadlih Wahyu Sardana, sedang belajar Pemrograman Mobile',
    style: TextStyle(color: Colors.red, fontSize: 14),
    textAlign: TextAlign.center,
   );
  }
}
```

Image Widget:
```dart
class MyImageWidget extends StatelessWidget {
  const MyImageWidget({super.key});
  @override
  Widget build(BuildContext context) {
   return const Image(image: AssetImage('logo_polinema.jpg'));
  }
}
```

Cupertino + Loading:
```dart
CupertinoButton(onPressed: () {}, child: const Text('Contoh button'));
const CupertinoActivityIndicator();
```

FAB:
```dart
FloatingActionButton(
  onPressed: () {},
  backgroundColor: Colors.pink,
  child: const Icon(Icons.thumb_up),
);
```

Dialog:
```dart
showDialog(
  context: context,
  builder: (_) => AlertDialog(
   title: const Text('My title'),
   content: const Text('This is my message.'),
   actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))],
  ),
);
```

Input:
```dart
const TextField(
  decoration: InputDecoration(
   border: OutlineInputBorder(),
   labelText: 'Nama',
  ),
);
```

Date Picker (fungsi inti):
```dart
final picked = await showDatePicker(
  context: context,
  initialDate: selectedDate,
  firstDate: DateTime(2015, 8),
  lastDate: DateTime(2101),
);
if (picked != null) setState(()=> selectedDate = picked);
```

---

## Konfigurasi Aset
pubspec.yaml:
```
flutter:
  assets:
   - logo_polinema.jpg
```

---

## Catatan
- Jalankan hanya satu fungsi `main()` aktif (komentari lainnya saat demonstrasi).  
- Gunakan commit pesan deskriptif: contoh "add text widget", "add date picker".  
- Pastikan screenshot berjalan di device fisik (Praktikum 2).  
- Pisahkan tiap contoh widget dalam file modular (sesuai instruksi).  

Selesai.  

# Laporan Praktikum Dart – Codelab 04 (Bagian 3)
Fokus: List, Set, Map, Spread / Control-flow List, Records (Dart 3)

---

## 👤 Data Mahasiswa
| Nama | NIM | Kelas |
|------|-----|-------|
| Ahmad Fadlih Wahyu Sardana | 2341720069 | TI-3H |

---

## 📑 Daftar Isi
1. Ringkasan Fitur
2. Praktikum 1 – List
3. Praktikum 2 – Set
4. Praktikum 3 – Map
5. Praktikum 4 – Spread & Control-flow List
6. Praktikum 5 – Records
7. Jawaban Tugas Praktikum
8. Referensi Kode
9. Rekomendasi

---

## 1. Ringkasan Fitur
| Konsep | Contoh | Catatan |
|--------|--------|---------|
| List | `[1,2,3]` | Terurut, izinkan duplikat |
| Set | `{'a','b'}` | Elemen unik, tidak berindeks |
| Map | `{'k':'v'}` | Key → Value |
| Spread | `[...list]` | Salin / gabung list |
| Null-aware spread | `[...?list]` | Abaikan jika null |
| Inline if | `['A', if (flag) 'B']` | Kondisional |
| Inline for | `['#0', for (var i in l) '#$i']` | Iteratif |
| Record | `('A', b:1)` | Bundel ringan |
| Akses record | `$1`, `.b` | Posisi / nama |

---

## 2. Praktikum 1 – List
Tujuan: Deklarasi, akses, mutasi, fixed-length list.

```dart
var list = [1, 2, 3];
list[1] = 1;

final listBaru = List<Object?>.filled(5, null);
listBaru[1] = "Ahmad Fadlih Wahyu Sardana";
listBaru[2] = "2341720069";
```
Screenshot: `img/codelab04_dart_part3_praktikum1.png`

---

## 3. Praktikum 2 – Set
Tujuan: Koleksi unik & perbedaan `{}` (Map vs Set).

```dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
var names1 = <String>{};
Set<String> names2 = {};
names1.add('Ahmad Fadlih Wahyu Sardana');
names2.addAll(['Ahmad Fadlih Wahyu Sardana', '2341720069']);
```
Screenshot: `img/codelab04_dart_part3_praktikum2.png`

---

## 4. Praktikum 3 – Map
Tujuan: Key–value, mutasi, tipe kuat.

```dart
var gifts = {'first': 'partridge', 'second': 'turtledoves', 'fifth': 1};
var mhs1 = <String, String>{};
mhs1['nama'] = 'Ahmad Fadlih Wahyu Sardana';
mhs1['nim'] = '2341720069';
```
Screenshot: `img/codelab04_dart_part3_praktikum3.png`

---

## 5. Praktikum 4 – Spread & Control-flow List
```dart
var listPraktikum4 = [1, 2, 3];
var list2 = [0, ...listPraktikum4];

var list1 = [1, 2, null];
var list3 = [0, ...?list1];

var promoActive = true;
var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];

var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
```
Screenshot: `img/codelab04_dart_part3_praktikum4.png`

---

## 6. Praktikum 5 – Records (Dart 3)
```dart
var record = ('first', a: 2, b: true, 'last');
(String, int) mahasiswa3 = ('Ahmad Fadlih Wahyu Sardana', 2341720069);

(int, int) tukar((int, int) pair) => (pair.$2, pair.$1);
var swapped = tukar((10, 20)); // (20, 10)
```
Screenshot: `img/codelab04_dart_part3_praktikum5.png`

---

## 7. Jawaban Tugas Praktikum

=== Jawaban Tugas Praktikum ===

Screenshot: `img/codelab04_tugaTugas_Praktikumcodelab04s.png`
1. Functions dalam bahasa Dart  
Functions adalah blok kode yang dapat dipanggil untuk melakukan tugas tertentu dan membuat kode modular serta reusable.  
Contoh:  
```dart
void f1(int a, String b);                 // Positional wajib
void f2(int a, [int? b]);                 // Positional opsional
void f3({int? age});                      // Named opsional
void f4({required String name});          // Named wajib
```

### 7.3 First-class Functions
```dart
var add = (int a, int b) => a + b;
int operate(int a, int b, int Function(int, int) op) => op(a, b);
```

### 7.4 Anonymous Function
```dart
var doubled = [1,2,3].map((n) => n * 2);
```

### 7.5 Lexical Scope & Closure
```dart
Function counter() {
  int c = 0;
  return () => ++c;
}
```

### 7.6 Return Multiple Values
```dart
(String, int) getUser() => ('Alice', 25);
```

### 7.7 Contoh Record di Proyek
```dart
(String, int) getUserData() => ('Ahmad', 21);
var data = getUserData();
print(data.$1); // Nama
```

---

## 8. Referensi Kode
Folder: `src/codelab04_dart_part3`  
Fungsi utama: `main`, `tukar`, `getUserData`

---

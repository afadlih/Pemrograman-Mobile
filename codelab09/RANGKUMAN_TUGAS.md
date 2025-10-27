# Rangkuman Tugas Praktikum Codelab09

## ✅ Yang Sudah Dikerjakan

### 1. Integrasi Praktikum 1 dan 2

✅ **SELESAI** - Praktikum 1 (Camera) dan Praktikum 2 (Filter Carousel) telah digabungkan dalam satu project: `kamera_flutter`

**Fitur yang Bekerja:**

- Camera preview dan capture foto
- Display foto hasil capture
- Filter carousel di bawah foto
- Real-time filter application
- Interactive carousel dengan smooth animation

**File yang Ditambahkan:**

```
kamera_flutter/lib/widget/
├── filter_selector.dart       ← Carousel dengan PageController
├── carousel_flowdelegate.dart ← Custom FlowDelegate untuk transform
└── filter_item.dart          ← Individual filter preview
```

**File yang Dimodifikasi:**

```
kamera_flutter/lib/widget/
└── displaypicture_screen.dart ← StatefulWidget dengan ValueNotifier
```

### 2. Dokumentasi di README.md

✅ **SELESAI** - README.md telah diupdate dengan:

- ✅ Penjelasan integrasi aplikasi
- ✅ Screenshot placeholders (4 screenshot)
- ✅ Cara kerja aplikasi
- ✅ Implementasi teknis
- ✅ Jawaban pertanyaan teoritis

### 3. Jawaban Pertanyaan Teoritis

#### A. Maksud `void async`

✅ **SELESAI** - Dijelaskan dengan detail:

- `void` = return type (tidak mengembalikan nilai)
- `async` = modifier untuk operasi asynchronous
- Mengapa perlu `async` untuk `await`
- Perbedaan `void` vs `Future<void>`
- Contoh kode dan analogi

#### B. Anotasi `@immutable` dan `@override`

✅ **SELESAI** - Dijelaskan dengan detail:

**`@immutable`:**

- Memastikan field harus final
- Meningkatkan performa Flutter
- Mencegah bugs dari perubahan state
- Contoh penggunaan dan best practice

**`@override`:**

- Dokumentasi eksplisit override method
- Compile-time check
- Mencegah typo
- Contoh deteksi error dan best practice

---

## 📱 Cara Menjalankan Aplikasi

```bash
cd d:\Pemrograman-Mobile\codelab09\kamera_flutter
flutter pub get
flutter run
```

**Catatan:** Gunakan physical device atau emulator dengan kamera untuk hasil optimal.

---

## 📸 Screenshot yang Perlu Ditambahkan

Silakan ambil screenshot berikut dan simpan di `codelab09/img/`:

1. **tugas_camera_preview.png** - Preview kamera dengan tombol capture
2. **tugas_filter_white.png** - Foto dengan filter putih (default)
3. **tugas_filter_color.png** - Foto dengan filter warna (merah/biru/hijau)
4. **tugas_carousel_detail.png** - Close-up carousel dengan ring seleksi

Lihat file `img/SCREENSHOT_GUIDE.md` untuk panduan lengkap.

---

## 🚀 Langkah Push ke Repository

Setelah screenshot ditambahkan:

```bash
cd d:\Pemrograman-Mobile

# Add semua perubahan
git add .

# Commit dengan pesan yang jelas
git commit -m "Complete Tugas Praktikum Codelab09: Merge Camera and Filter Carousel"

# Push ke repository
git push origin main
```

---

## 📝 Checklist Akhir

- [x] Praktikum 1 dan 2 digabung dalam satu project
- [x] Aplikasi dapat capture foto
- [x] Filter carousel bekerja dengan baik
- [x] README.md diupdate dengan dokumentasi lengkap
- [x] Pertanyaan teoritis dijawab dengan detail
- [x] Screenshot placeholders sudah ada di README
- [ ] **TODO**: Ambil screenshot dari aplikasi
- [ ] **TODO**: Upload screenshot ke folder img/
- [ ] **TODO**: Push semua perubahan ke repository

---

## 🎯 Hasil Akhir

**Repository:** [github.com/afadlih/Pemrograman-Mobile](https://github.com/afadlih/Pemrograman-Mobile)

**Project Location:** `codelab09/kamera_flutter/`

**Identitas:**

- Nama: Ahmad Fadlih Wahyu Sardana
- NIM: 2341720069
- Kelas: TI-3F
- No. Absen: 03

---

✨ **Tugas Praktikum telah diselesaikan dengan baik!**

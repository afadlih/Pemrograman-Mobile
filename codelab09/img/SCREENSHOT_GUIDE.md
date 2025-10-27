# 📸 Screenshot Guidelines — Codelab 09

Dokumentasi visual untuk **3 project** dalam Codelab 09. Setiap project memiliki screenshot yang berbeda sesuai fiturnya.

---

## 📂 Struktur Screenshot

```
img/
├── kamera_flutter/          # Praktikum 1 (Kamera only)
│   ├── camera_preview.png
│   ├── photo_captured.png
│   └── display_screen.png
│
├── photo_filter_carousel/   # Praktikum 2 (Filter only)
│   ├── filter_white.png
│   ├── filter_color.png
│   ├── filter_carousel.png
│   └── filter_animation.png
│
└── camera_filter_app/       # Integrasi (Kamera + Filter)
    ├── app_preview.png
    ├── photo_capture.png
    ├── display_with_filter_white.png
    ├── display_with_filter_color.png
    └── carousel_detail.png
```

---

## 1️⃣ Screenshot Kamera Flutter (Praktikum 1)

### 📷 camera_preview.png
- **Deskripsi:** Tampilan preview kamera sebelum mengambil foto
- **Cara:**
  1. Buka aplikasi `kamera_flutter`
  2. Screenshot tampilan preview kamera
  3. Pastikan tombol capture terlihat jelas

### 📸 photo_captured.png
- **Deskripsi:** Proses mengambil foto (tombol capture ditekan)
- **Cara:**
  1. Screenshot saat menekan tombol capture
  2. Atau capture toast/snackbar konfirmasi foto tersimpan

### 🖼️ display_screen.png
- **Deskripsi:** Tampilan foto hasil capture (tanpa filter)
- **Cara:**
  1. Setelah foto diambil, navigasi ke DisplayPictureScreen
  2. Screenshot tampilan foto murni (tidak ada filter carousel)
  3. Pastikan AppBar dengan nama foto terlihat

---

## 2️⃣ Screenshot Photo Filter Carousel (Praktikum 2)

### ⚪ filter_white.png
- **Deskripsi:** Filter putih (default) terseleksi
- **Cara:**
  1. Buka aplikasi `photo_filter_carousel`
  2. Screenshot tampilan dengan filter putih aktif
  3. Ring seleksi putih harus terlihat di carousel

### 🔴 filter_color.png
- **Deskripsi:** Filter berwarna (merah/biru/hijau) diterapkan
- **Cara:**
  1. Scroll carousel ke salah satu filter berwarna
  2. Screenshot tampilan foto dengan filter warna
  3. Tunjukkan perubahan warna pada foto

### 🎠 filter_carousel.png
- **Deskripsi:** Detail carousel dengan multiple filters visible
- **Cara:**
  1. Screenshot area carousel menunjukkan 5 filter items
  2. Tunjukkan scale & opacity effect
  3. Pastikan gradient shadow terlihat

### ✨ filter_animation.png (Optional)
- **Deskripsi:** Transisi animasi saat pindah filter
- **Cara:**
  1. Record GIF saat scroll carousel
  2. Atau screenshot mid-transition

---

## 3️⃣ Screenshot Camera Filter App (Integrasi)

### 📷 app_preview.png
- **Deskripsi:** Preview kamera di aplikasi integrasi
- **Cara:**
  1. Buka aplikasi `camera_filter_app`
  2. Screenshot tampilan awal preview kamera
  3. Tunjukkan UI yang sama dengan kamera_flutter

### 📸 photo_capture.png
- **Deskripsi:** Proses capture foto
- **Cara:**
  1. Screenshot saat tombol capture ditekan
  2. Atau tampilan konfirmasi foto tersimpan

### ⚪ display_with_filter_white.png
- **Deskripsi:** Foto dengan filter putih + carousel
- **Cara:**
  1. Setelah foto diambil, screenshot DisplayPictureScreen
  2. Filter putih terseleksi di carousel
  3. Tunjukkan foto hasil capture dengan carousel di bawah

### 🔵 display_with_filter_color.png
- **Deskripsi:** Foto dengan filter berwarna diterapkan
- **Cara:**
  1. Scroll carousel ke filter biru/merah/hijau
  2. Screenshot tampilan foto dengan filter warna aktif
  3. Tunjukkan perubahan warna real-time

### 🎯 carousel_detail.png
- **Deskripsi:** Close-up carousel dengan foto hasil capture
- **Cara:**
  1. Screenshot fokus pada area carousel
  2. Tunjukkan:
     - Ring seleksi putih
     - Scale & opacity effect
     - Gradient shadow
     - Preview foto di setiap filter item

---

## 🛠️ Cara Mengambil Screenshot

### 📱 Android (Emulator atau Physical Device)
```bash
# Shortcut keyboard
Power + Volume Down

# Via ADB (jika diperlukan)
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

### 🍎 iOS (Simulator atau Physical Device)
```bash
# iOS Simulator
Cmd + S

# Atau via menu
Device > Screenshot

# Physical device
Power + Volume Up (tergantung model)
```

### 💻 VS Code (Flutter DevTools)
1. Buka **Flutter DevTools**
2. Tab **Flutter Inspector**
3. Klik icon **Screenshot** (📷)
4. Gambar tersimpan di Downloads

### 🎥 Recording GIF (Optional)
```bash
# Gunakan tools seperti:
- ScreenToGif (Windows)
- LICEcap (Windows/Mac)
- Peek (Linux)
- Flutter DevTools > Performance > Timeline
```

---

## 📥 Cara Menambahkan Screenshot ke Repository

### 1. Organize Screenshots
```bash
# Buat folder struktur
cd d:\Pemrograman-Mobile\codelab09\img
mkdir kamera_flutter photo_filter_carousel camera_filter_app

# Copy screenshots ke folder masing-masing
copy screenshot1.png kamera_flutter\camera_preview.png
copy screenshot2.png photo_filter_carousel\filter_white.png
# ... dan seterusnya
```

### 2. Git Add & Commit
```bash
cd d:\Pemrograman-Mobile

# Add semua screenshots
git add codelab09/img/

# Commit dengan pesan jelas
git commit -m "Add screenshots for all 3 projects in Codelab09

- kamera_flutter: Camera preview and display screens
- photo_filter_carousel: Filter carousel with color variations
- camera_filter_app: Integrated camera + filter screenshots"

# Push ke repository
git push origin main
```

---

## 📐 Format & Kualitas Screenshot

| Aspek | Rekomendasi |
|-------|-------------|
| **Format** | PNG (lossless) |
| **Resolusi** | Minimal 720p (1280x720) |
| **Aspect Ratio** | 9:16 atau 9:19 (portrait) |
| **File Size** | < 500 KB per screenshot |
| **Naming** | snake_case, descriptive |

### Optimize Screenshot (Optional)
```bash
# Gunakan TinyPNG atau ImageOptim
# Atau via command line (jika ada ImageMagick):
magick convert input.png -quality 85 output.png
```

---

## ✅ Checklist Screenshot

### Kamera Flutter (3 screenshots)
- [ ] `camera_preview.png` - Preview kamera
- [ ] `photo_captured.png` - Proses capture
- [ ] `display_screen.png` - Display tanpa filter

### Photo Filter Carousel (3-4 screenshots)
- [ ] `filter_white.png` - Filter putih
- [ ] `filter_color.png` - Filter berwarna
- [ ] `filter_carousel.png` - Detail carousel
- [ ] `filter_animation.png` (Optional) - Animasi GIF

### Camera Filter App (5 screenshots)
- [ ] `app_preview.png` - Preview kamera
- [ ] `photo_capture.png` - Capture process
- [ ] `display_with_filter_white.png` - Foto + filter putih
- [ ] `display_with_filter_color.png` - Foto + filter warna
- [ ] `carousel_detail.png` - Close-up carousel

**Total:** 11-12 screenshots minimum

---

## 💡 Tips Mengambil Screenshot Berkualitas

1. **Gunakan physical device** untuk hasil yang lebih realistis
2. **Pastikan UI bersih** - Tidak ada notifikasi yang mengganggu
3. **Gunakan mode terang/gelap konsisten** - Pilih salah satu
4. **Screenshot pada saat yang tepat** - Tunggu animasi selesai
5. **Crop jika perlu** - Fokuskan pada area yang relevan
6. **Tambahkan keterangan** - Gunakan arrow atau highlight jika perlu

---

## 📝 Template Commit Message

```
Add screenshots for Codelab09 - [Project Name]

Screenshots included:
- Camera preview with capture button
- Photo display with/without filters
- Filter carousel with color variations
- Carousel detail showing ring selection

Resolves: #issue-number (jika ada)
```

---

## 📞 Troubleshooting

### Problem: Screenshot terlalu besar (> 1 MB)
**Solusi:** Compress menggunakan TinyPNG atau ImageOptim

### Problem: Warna screenshot berbeda di laptop vs phone
**Solusi:** Gunakan color profile yang konsisten (sRGB)

### Problem: Tidak bisa screenshot di emulator
**Solusi:** Gunakan Flutter DevTools > Inspector > Screenshot

### Problem: GIF terlalu besar
**Solusi:** 
- Kurangi frame rate (10-15 fps cukup)
- Reduce resolution ke 50-75%
- Gunakan tools kompresi GIF

---

## 🎓 Kesimpulan

Dokumentasi screenshot untuk **3 project terpisah** dalam Codelab 09:

| Project | Screenshot Count | Folder |
|---------|-----------------|--------|
| `kamera_flutter` | 2-3 files | `img/kamera_flutter/` |
| `photo_filter_carousel` | 3-4 files | `img/photo_filter_carousel/` |
| `camera_filter_app` | 4-5 files | `img/camera_filter_app/` |
| **Total** | **10-12 files** | **3 folders** |

### ✅ Quick Checklist

- [ ] Semua 3 project sudah di-run dan tested
- [ ] Screenshot diambil dengan kualitas bagus (PNG, >720p)
- [ ] Semua screenshot disimpan di folder yang benar
- [ ] File naming sesuai panduan (snake_case)
- [ ] Screenshot di-commit ke git repository
- [ ] README.md sudah di-update dengan path screenshot

---

**Good luck! 🚀**

*Panduan ini dibuat untuk mempermudah dokumentasi visual Codelab 09*

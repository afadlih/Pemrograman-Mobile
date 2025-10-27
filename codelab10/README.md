# Codelab 10: Dasar State Management

## Informasi Mahasiswa
- **Nama**: Ahmad Fadlih
- **NIM**: 2341720069
- **Kelas**: TI-3F / 03

---

## Praktikum 1: Dasar State dengan Model-View

### Tujuan Praktikum
Praktikum ini bertujuan untuk memahami konsep dasar state management dalam Flutter menggunakan pola Model-View. Kita akan membuat aplikasi Master Plan sederhana untuk mengelola daftar tugas (to-do list).

---

### Hasil Akhir Aplikasi

![Master Plan App Demo](./img/langkah9_demo)

**Penjelasan Aplikasi:**
Aplikasi Master Plan yang telah dibuat merupakan aplikasi manajemen tugas sederhana dengan fitur-fitur berikut:
1. **Menambah Tugas**: Menggunakan tombol FloatingActionButton (+) di pojok kanan bawah
2. **Menandai Tugas Selesai**: Checkbox di sebelah kiri setiap tugas untuk menandai status penyelesaian
3. **Mengedit Deskripsi Tugas**: TextFormField yang dapat langsung diedit untuk mengubah nama tugas
4. **Keyboard Dismiss**: Keyboard otomatis tertutup saat scroll di platform iOS

---

### Jawaban Soal Praktikum

#### Soal 1: Dokumentasi dan Hasil Akhir
Langkah-langkah praktikum telah diselesaikan . Struktur project yang telah dibuat:

```
lib/
├── models/
│   ├── task.dart          # Model untuk Task
│   ├── plan.dart          # Model untuk Plan
│   └── data_layer.dart    # Export file untuk models
├── views/
│   └── plan_screen.dart   # UI Screen utama
└── main.dart              # Entry point aplikasi
```


---

#### Soal 2: Penjelasan Langkah 4

**Langkah 4** membuat file `data_layer.dart` yang berisi:
```dart
export 'plan.dart';
export 'task.dart';
```

**Maksud dan Tujuan:**
- **Centralized Import**: File ini berfungsi sebagai **barrel file** atau **index file** yang mengumpulkan semua export dari model-model dalam satu tempat
- **Simplifikasi Import**: Daripada mengimport setiap file model secara terpisah, kita cukup import satu file `data_layer.dart`
- **Maintainability**: Memudahkan maintenance kode, jika ada penambahan model baru, cukup tambahkan export di file ini

**Contoh:**

Tanpa `data_layer.dart`:
```dart
import '../models/task.dart';
import '../models/plan.dart';
```

Dengan `data_layer.dart`:
```dart
import '../models/data_layer.dart';
```

Lebih clean dan mudah dikelola, terutama jika model bertambah banyak.

---

#### Soal 3: Variabel `plan` di Langkah 6

**Kode di Langkah 6:**
```dart
class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();
  // ...
}
```

**Mengapa perlu variabel `plan`?**
- Variabel `plan` adalah **state** dari widget PlanScreen
- Menyimpan data plan yang sedang aktif, termasuk daftar tasks
- Digunakan untuk mengelola dan merender UI berdasarkan data yang ada
- Setiap perubahan pada `plan` akan memicu rebuild UI melalui `setState()`

**Mengapa dibuat konstanta (`const`)?**
- Menggunakan `const Plan()` untuk **initial value** karena saat pertama kali dibuat, plan masih kosong
- `const` membuat object immutable dan lebih efisien di memory
- Flutter dapat mengoptimasi widget yang const sehingga performa lebih baik
- Nilai awal konstanta ini akan diganti saat user mulai menambah tasks melalui `setState()`

**Keuntungan Immutability:**
- State management lebih predictable
- Memudahkan debugging karena setiap perubahan state eksplisit
- Mencegah side effects yang tidak diinginkan

---

#### Soal 4: Capture Hasil Langkah 9

![Langkah 9 Demo](./img/langkah9_demo.gif)

**Penjelasan Apa yang Telah Dibuat:**

Pada Langkah 9,  telah mengimplementasikan method `_buildTaskTile()` yang membuat tile untuk setiap task dalam list. Komponen yang dibuat:

1. **ListTile Widget**: Container untuk menampilkan satu item task
   
2. **Checkbox (leading)**:
   - Menampilkan status complete/incomplete dari task
   - `onChanged`: Ketika di-klik, akan memanggil `setState()` untuk update status `complete`
   - Membuat copy baru dari list tasks dan update task di index tertentu

3. **TextFormField (title)**:
   - Field input untuk mengedit deskripsi task
   - `initialValue`: Menampilkan deskripsi task yang ada
   - `onChanged`: Setiap perubahan teks akan langsung update state melalui `setState()`

4. **State Management Pattern**:
   ```dart
   setState(() {
     plan = Plan(
       name: plan.name,
       tasks: List<Task>.from(plan.tasks)
         ..[index] = Task(
           description: text,
           complete: task.complete,
         ),
     );
   });
   ```
   - Membuat **copy baru** dari Plan (immutability)
   - Update task spesifik di index tertentu
   - Flutter akan otomatis rebuild UI dengan data baru

**Hasil yang Dicapai:**
- User dapat menambah task dengan tombol +
- User dapat mencentang checkbox untuk menandai task selesai
- User dapat mengedit nama/deskripsi task secara langsung
- Semua perubahan langsung terlihat di UI (reactive)

---

#### Soal 5: Kegunaan Method di Langkah 11 dan 13

**Langkah 11 - Method `initState()`:**
```dart
@override
void initState() {
  super.initState();
  scrollController = ScrollController()
    ..addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
}
```

**Kegunaan dalam Lifecycle State:**
- `initState()` dipanggil **sekali** saat widget pertama kali dibuat (initialization phase)
- Digunakan untuk setup awal yang hanya perlu dilakukan satu kali
- Dalam kasus ini: menginisialisasi `ScrollController` dan menambahkan listener
- Listener berfungsi untuk dismiss keyboard saat user scroll (UX improvement)
- **Timing**: Dipanggil setelah constructor tapi sebelum `build()` pertama kali

**Lifecycle Position**: `Constructor → initState() → build() → ...`

---

**Langkah 13 - Method `dispose()`:**
```dart
@override
void dispose() {
  scrollController.dispose();
  super.dispose();
}
```

**Kegunaan dalam Lifecycle State:**
- `dispose()` dipanggil saat widget akan **dihapus secara permanen** dari widget tree
- Digunakan untuk **cleanup resources** agar tidak terjadi memory leak
- Dalam kasus ini: membebaskan memory yang digunakan oleh `ScrollController`
- Sangat penting untuk dispose controller, stream, animation, dll
- **Timing**: Dipanggil saat widget removed dari tree (tidak akan pernah rebuild lagi)

**Lifecycle Position**: `... → deactivate() → dispose() → [DESTROYED]`

---

**Mengapa Kedua Method Ini Penting?**

1. **Memory Management**: 
   - `initState()` → allocate resources
   - `dispose()` → deallocate resources
   - Mencegah memory leak

2. **Performance**:
   - Resources dibuat dan dihancurkan pada waktu yang tepat
   - Tidak ada waste resources

3. **Best Practice**:
   - Setiap controller/listener yang dibuat di `initState()` harus di-dispose di `dispose()`
   - Pattern: `create → use → cleanup`

**Contoh Analogi:**
- `initState()` = Menyewa rumah dan setup perabotan
- `dispose()` = Membersihkan dan mengembalikan kunci sebelum pindah

---

### Struktur Kode

#### 1. Model Layer

**task.dart** - Model untuk individual task:
```dart
class Task {
  final String description;
  final bool complete;

  const Task({this.complete = false, this.description = ''});
}
```

**plan.dart** - Model untuk plan yang berisi list tasks:
```dart
import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});
}
```

**data_layer.dart** - Export barrel file:
```dart
export 'plan.dart';
export 'task.dart';
```

---

#### 2. View Layer

**plan_screen.dart** - Screen utama dengan state management:
```dart
import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plan Ahmad Fadlih')),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          plan = Plan(
            name: plan.name,
            tasks: List<Task>.from(plan.tasks)..add(const Task()),
          );
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index),
    );
  }

  Widget _buildTaskTile(Task task, int index) {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
          });
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(description: text, complete: task.complete),
            );
          });
        },
      ),
    );
  }
}
```

---

#### 3. Main App

**main.dart** - Entry point aplikasi:
```dart
import 'package:flutter/material.dart';
import './views/plan_screen.dart';

void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanScreen(),
    );
  }
}
```

---

### Konsep yang Dipelajari

1. **Model-View Pattern**:
   - Separation of concerns antara data (model) dan UI (view)
   - Model: Task dan Plan sebagai struktur data
   - View: PlanScreen untuk menampilkan dan interaksi

2. **State Management dengan StatefulWidget**:
   - Menggunakan `setState()` untuk update UI
   - State disimpan di variabel `plan`
   - Immutability pattern untuk predictable state

3. **Widget Lifecycle**:
   - `initState()`: Initialization phase
   - `build()`: Rendering phase
   - `dispose()`: Cleanup phase

4. **Controller Management**:
   - ScrollController untuk kontrol scrolling
   - Listener untuk dismiss keyboard
   - Proper cleanup di dispose()

5. **Reactive UI**:
   - UI otomatis update saat state berubah
   - User interaction langsung mempengaruhi state
   - Real-time feedback untuk user

---

### Screenshot Tambahan

#### Aplikasi Awal (Kosong)
![App Empty State](./img/app_empty.png)

#### Menambah Task
![Adding Tasks](./img/app_adding_tasks.png)

#### Task dengan Checkbox
![Tasks with Checkbox](./img/app_with_checkbox.png)

#### Mengedit Task
![Editing Task](./img/app_editing.png)

---

### Cara Menjalankan Aplikasi

1. Clone repository ini
2. Masuk ke direktori project:
   ```bash
   cd codelab10/master_plan
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```
5. **Penting**: Gunakan **Hot Restart** (bukan Hot Reload) untuk melihat perubahan state

---

### Kesimpulan

Praktikum ini mengimplementasikan aplikasi Master Plan sederhana dengan konsep:
-  Model-View architecture pattern
-  StatefulWidget untuk state management
-  Immutable state dengan const constructors
-  Proper widget lifecycle management (initState & dispose)
-  Interactive UI dengan real-time updates
-  Keyboard handling untuk iOS platform



---

**Link Repository**: [https://github.com/afadlih/Pemrograman-Mobile](https://github.com/afadlih/Pemrograman-Mobile)



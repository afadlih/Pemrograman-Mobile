# Codelab 10: Dasar State Management

## Informasi Mahasiswa
- **Nama**: Ahmad Fadlih
- **NIM**: 2341720069
- **NIM**: 2341720069
- **Kelas**: TI-3F / 03

---

## Praktikum 1: Dasar State dengan Model-View

### Tujuan Praktikum
Praktikum ini bertujuan untuk memahami konsep dasar state management dalam Flutter menggunakan pola Model-View.akan membuat aplikasi Master Plan sederhana untuk mengelola daftar tugas (to-do list).

---

### Hasil Akhir Aplikasi

![Master Plan App Demo](./img/langkah9_demo.gif)

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
- **Simplifikasi Import**: Daripada mengimport setiap file model secara terpisah,  cukup import satu file `data_layer.dart`
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
![App Empty State](./img/app_empty.jpeg)

#### Menambah Task
![Adding Tasks](./img/app_adding_task.jpeg)

#### Task dengan Checkbox
![Tasks with Checkbox](./img/app_with_checkbox.jpeg)

#### Mengedit Task
![Editing Task](./img/app_editting.jpeg)

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

*## Praktikum 2: Mengelola Data Layer dengan InheritedWidget dan InheritedNotifier

### Tujuan Praktikum
Praktikum 2 ini bertujuan untuk memisahkan data layer dari view layer menggunakan **InheritedWidget** dan **InheritedNotifier**. Dengan cara inidapat mengelola state aplikasi dengan lebih terstruktur dan scalable.

---

### 📸 Screenshot Praktikum 2
**Status**: ✅ Demo GIF tersedia

Screenshot dan demo aplikasi tersedia di folder `img/`:
- ✅ `praktikum2_demo.gif` - Demo lengkap aplikasi dengan InheritedNotifier
- ✅ `langkah9_demo.gif` - Demo implementasi langkah 9

---

### Konsep InheritedWidget

**InheritedWidget** adalah jenis widget khusus di Flutter yang berbeda dari StatelessWidget dan StatefulWidget:

- **StatelessWidget**: Widget statis untuk UI
- **StatefulWidget**: Widget dinamis untuk UI
- **InheritedWidget**: Widget untuk meneruskan data ke sub-widget turunannya

**Karakteristik InheritedWidget:**
1. Tidak tampil di screen (invisible untuk user)
2. Dapat meneruskan data ke widget children
3. Berguna untuk komunikasi antara view dan data layers
4. Memungkinkan data sharing tanpa passing props secara manual

---

### Hasil Akhir Aplikasi

![Master Plan dengan InheritedNotifier](./img/praktikum2_demo.gif)

**Perubahan yang Terlihat:**
- Terdapat **progress indicator** di bagian bawah screen
- Menampilkan jumlah task yang sudah selesai (contoh: "2 out of 5 tasks")
- UI otomatis update saat task ditambahkan atau dicentang
- Struktur kode lebih terorganisir dengan pemisahan concerns

---

### Struktur Project Setelah Praktikum 2

```
lib/
├── models/
│   ├── task.dart          # Model untuk Task
│   ├── plan.dart          # Model untuk Plan (+ method baru)
│   └── data_layer.dart    # Export file untuk models
├── provider/
│   └── plan_provider.dart # InheritedNotifier untuk state management
├── views/
│   └── plan_screen.dart   # UI Screen (refactored)
└── main.dart              # Entry point (updated dengan PlanProvider)
```

---

### Penjelasan Langkah-Langkah

#### Langkah 1: Membuat PlanProvider (InheritedNotifier)

File: `lib/provider/plan_provider.dart`

```dart
import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider(
      {super.key,
      required Widget child,
      required ValueNotifier<Plan> notifier})
      : super(child: child, notifier: notifier);

  static ValueNotifier<Plan> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
```

**Penjelasan:**
- **InheritedNotifier**: Extends InheritedWidget dengan kemampuan notifikasi otomatis
- **ValueNotifier<Plan>**: Holder untuk data Plan yang bisa di-observe
- **of(context)**: Static method untuk mengakses data dari widget tree
- **dependOnInheritedWidgetOfExactType**: Mencari PlanProvider di widget tree dan membuat widget rebuild saat data berubah

---

#### Langkah 2: Update main.dart

**Perubahan:**
- Wrap `PlanScreen` dengan `PlanProvider`
- Inisialisasi `ValueNotifier<Plan>` sebagai state global

```dart
return MaterialApp(
  theme: ThemeData(primarySwatch: Colors.purple),
  home: PlanProvider(
    notifier: ValueNotifier<Plan>(const Plan()),
    child: const PlanScreen(),
  ),
);
```

**Mengapa penting?**
- `PlanProvider` menjadi root dari state management
- `ValueNotifier` sebagai single source of truth untuk data Plan
- Semua widget children bisa mengakses dan memodifikasi Plan

---

#### Langkah 3: Tambah Method di plan.dart

**Method baru:**

```dart
int get completedCount => tasks.where((task) => task.complete).length;

String get completenessMessage =>
    '$completedCount out of ${tasks.length} tasks';
```

**Fungsi:**
- **completedCount**: Menghitung jumlah task yang sudah complete (checked)
- **completenessMessage**: Generate string untuk ditampilkan di UI footer
- Menggunakan **getter** untuk computed property (reactive)

**Contoh Output:**
- "0 out of 3 tasks" (belum ada yang selesai)
- "2 out of 5 tasks" (2 dari 5 task selesai)

---

#### Langkah 4-5: Refactor _buildAddTaskButton

**Sebelum (Praktikum 1):**
```dart
Widget _buildAddTaskButton() {
  return FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      setState(() {  // Menggunakan setState
        plan = Plan(...);
      });
    },
  );
}
```

**Sesudah (Praktikum 2):**
```dart
Widget _buildAddTaskButton(BuildContext context) {
  ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
  return FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      Plan currentPlan = planNotifier.value;
      planNotifier.value = Plan(...);  // Update ValueNotifier
    },
  );
}
```

**Perubahan Kunci:**
1. Tambah parameter `BuildContext context`
2. Ambil `planNotifier` dari `PlanProvider.of(context)`
3. Tidak pakai `setState()` lagi, langsung update `planNotifier.value`
4. Otomatis trigger rebuild pada widget yang listen ke ValueNotifier

---

#### Langkah 6: Refactor _buildTaskTile

**Perubahan:**
- Tambah parameter `BuildContext context`
- Gunakan `PlanProvider.of(context)` untuk akses state
- Ganti `TextField` → `TextFormField` (lebih mudah untuk inisial value)
- Update state via `planNotifier.value` bukan `setState()`

```dart
Widget _buildTaskTile(Task task, int index, BuildContext context) {
  ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
  return ListTile(
    leading: Checkbox(
      value: task.complete,
      onChanged: (selected) {
        Plan currentPlan = planNotifier.value;
        planNotifier.value = Plan(...);
      }
    ),
    title: TextFormField(...),
  );
}
```

---

#### Langkah 7: Update _buildList

**Perubahan:**
- Tambah parameter `Plan plan` (data dikirim dari parent)
- Pass `context` ke `_buildTaskTile`

```dart
Widget _buildList(Plan plan) {
  return ListView.builder(
    controller: scrollController,
    itemCount: plan.tasks.length,
    itemBuilder: (context, index) =>
        _buildTaskTile(plan.tasks[index], index, context),
  );
}
```

---

#### Langkah 8-9: Refactor build() dengan ValueListenableBuilder

**Kode Lengkap:**

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Master Plan Ahmad Fadlih')),
    body: ValueListenableBuilder<Plan>(
      valueListenable: PlanProvider.of(context),
      builder: (context, plan, child) {
        return Column(
          children: [
            Expanded(child: _buildList(plan)),
            SafeArea(child: Text(plan.completenessMessage))
          ],
        );
      },
    ),
    floatingActionButton: _buildAddTaskButton(context),
  );
}
```

**Penjelasan Komponen:**

1. **ValueListenableBuilder**:
   - Widget yang rebuild otomatis saat ValueNotifier berubah
   - `valueListenable`: PlanProvider.of(context) - sumber data
   - `builder`: Function yang dipanggil setiap data berubah
   - Parameter `plan`: data terbaru dari ValueNotifier

2. **Column**:
   - Layout vertical untuk list dan footer

3. **Expanded**:
   - Wrap `_buildList(plan)` agar mengisi ruang tersisa
   - Prevent overflow saat ada SafeArea di bawah

4. **SafeArea**:
   - Widget untuk menghindari area unsafe (notch, home indicator)
   - Berisi `Text(plan.completenessMessage)` - progress counter
   - Otomatis update saat task complete/incomplete berubah

---

### Perbandingan: Sebelum vs Sesudah

| Aspek | Praktikum 1 (StatefulWidget) | Praktikum 2 (InheritedNotifier) |
|-------|------------------------------|----------------------------------|
| **State Storage** | `Plan plan = const Plan()` di State | `ValueNotifier<Plan>` di Provider |
| **State Update** | `setState(() { plan = ... })` | `planNotifier.value = ...` |
| **Data Access** | Direct access via `plan` | `PlanProvider.of(context)` |
| **Rebuild Trigger** | `setState()` manual | ValueNotifier otomatis |
| **Data Sharing** | Tidak bisa ke widget lain | Bisa diakses semua children |
| **Scalability** | Sulit untuk app besar | Mudah di-scale |
| **Separation of Concerns** | View dan data tercampur | View dan data terpisah |

---

### Keuntungan Menggunakan InheritedNotifier

1. **Separation of Concerns**:
   - Model: Data struktur (Task, Plan)
   - Provider: State management logic
   - View: UI presentation

2. **Data Sharing**:
   - Satu sumber data bisa diakses banyak widget
   - Tidak perlu passing props bertingkat-tingkat

3. **Reactive Updates**:
   - Widget otomatis rebuild saat data berubah
   - Tidak perlu panggil setState() manual

4. **Scalability**:
   - Mudah menambah provider baru untuk data lain
   - Pattern yang konsisten untuk state management

5. **Testability**:
   - Provider bisa di-mock untuk testing
   - Logic terpisah dari UI

---

### Konsep yang Dipelajari

#### 1. InheritedWidget vs InheritedNotifier

**InheritedWidget**:
- Base class untuk widget yang meneruskan data
- Rebuild manual (harus panggil updateShouldNotify)

**InheritedNotifier**:
- Extends InheritedWidget
- Otomatis rebuild saat Listenable (seperti ValueNotifier) berubah
- Lebih mudah digunakan untuk reactive state

---

#### 2. ValueNotifier dan ValueListenableBuilder

**ValueNotifier<T>**:
- Class untuk menyimpan single value
- Extends ChangeNotifier
- Notify listeners saat value berubah

```dart
ValueNotifier<Plan> planNotifier = ValueNotifier(const Plan());
planNotifier.value = newPlan;  // Trigger notification
```

**ValueListenableBuilder**:
- Widget yang listen ke ValueNotifier
- Rebuild otomatis saat value berubah
- Efisien: hanya rebuild widget dalam builder

```dart
ValueListenableBuilder<Plan>(
  valueListenable: planNotifier,
  builder: (context, plan, child) {
    return Text(plan.completenessMessage);
  },
)
```

---

#### 3. Dependency Injection Pattern

**dependOnInheritedWidgetOfExactType**:
- Mencari widget di tree berdasarkan type
- Mendaftarkan widget sebagai dependent
- Widget otomatis rebuild saat InheritedWidget update

```dart
static ValueNotifier<Plan> of(BuildContext context) {
  return context
      .dependOnInheritedWidgetOfExactType<PlanProvider>()!
      .notifier!;
}
```

---

### Flow Data dalam Aplikasi

```
main.dart
  └─ PlanProvider (ValueNotifier<Plan>)
      └─ PlanScreen
          ├─ ValueListenableBuilder (listen to changes)
          │   ├─ ListView (_buildList)
          │   │   └─ ListTile (_buildTaskTile)
          │   │       ├─ Checkbox → update planNotifier
          │   │       └─ TextFormField → update planNotifier
          │   └─ SafeArea (completenessMessage)
          └─ FloatingActionButton → update planNotifier
```

---

### Screenshot Aplikasi

#### Demo Lengkap Aplikasi
![Praktikum 2 Demo - InheritedNotifier](./img/praktikum2_demo.gif)
*Demo aplikasi Master Plan dengan InheritedNotifier dan progress counter*

#### Demo Langkah 9
![Langkah 9 Demo](./img/langkah9_demo.gif)
*Demo implementasi ValueListenableBuilder dan SafeArea footer*

---


---

### Jawaban Soal Tugas Praktikum 2

#### Soal 1: Dokumentasi dan Hasil Akhir

Langkah-langkah Praktikum 2 telah diselesaikan. Berikut adalah implementasinya:

**Struktur Project:**
```
lib/
├── models/
│   ├── task.dart          
│   ├── plan.dart          # Ditambahkan method completedCount & completenessMessage
│   └── data_layer.dart    
├── provider/
│   └── plan_provider.dart # BARU - InheritedNotifier untuk state management
├── views/
│   └── plan_screen.dart
    └── plan_creator_screen.dart
└── main.dart              # Diupdate dengan PlanProvider wrapper
```

**Fitur yang Berhasil Diimplementasikan:**
- InheritedNotifier untuk state management
- ValueNotifier untuk reactive state
- ValueListenableBuilder untuk auto-rebuild
- Progress counter di footer ("X out of Y tasks")
- Separation of concerns (Model-Provider-View)

**GIF Hasil Akhir:**

![Praktikum 2 Demo](./img/praktikum2_demo.gif)

**Penjelasan:**
Aplikasi Master Plan sekarang memiliki fitur tambahan berupa **progress counter** di bagian bawah screen yang menampilkan jumlah task yang sudah diselesaikan. Misalnya "2 out of 5 tasks" berarti 2 dari 5 task sudah dicentang. Progress ini otomatis update secara real-time saat:
- Task baru ditambahkan
- Checkbox dicentang/uncheck
- Task diedit

State management sekarang menggunakan **InheritedNotifier** sehingga data dapat dishare ke seluruh widget tree tanpa perlu passing props manual.

---

#### Soal 2: InheritedWidget pada Langkah 1

**Mana yang dimaksud InheritedWidget pada langkah 1?**

Pada langkah 1, yang dimaksud **InheritedWidget** adalah class `PlanProvider` yang extends `InheritedNotifier<ValueNotifier<Plan>>`:

```dart
class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProvider(
      {super.key,
      required Widget child,
      required ValueNotifier<Plan> notifier})
      : super(child: child, notifier: notifier);

  static ValueNotifier<Plan> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
```

**Penjelasan Komponen:**

1. **`PlanProvider`**: Nama class custom 
2. **`extends InheritedNotifier<ValueNotifier<Plan>>`**: 
   - Mewarisi dari `InheritedNotifier` (bukan `InheritedWidget` langsung)
   - Generic type: `ValueNotifier<Plan>` - tipe data yang akan di-notify

3. **`super(child: child, notifier: notifier)`**:
   - Pass child widget ke parent
   - Pass notifier untuk mekanisme notification

4. **Method `of(BuildContext context)`**:
   - Static method untuk dependency injection
   - Menggunakan `dependOnInheritedWidgetOfExactType<PlanProvider>()`
   - Return ValueNotifier yang bisa diakses dan dimodifikasi

---

**Mengapa yang digunakan InheritedNotifier?**

Flutter menyediakan beberapa jenis Inherited widget:

| Class | Fungsi | Use Case |
|-------|--------|----------|
| **InheritedWidget** | Base class, rebuild manual | Data statis atau jarang berubah |
| **InheritedNotifier** | Auto-rebuild dengan Listenable | Data reactive yang sering berubah |
| **InheritedModel** | Selective rebuild | Data kompleks dengan banyak aspect |

**Alasan menggunakan InheritedNotifier:**

1. **Automatic Notification**:
   ```dart
   // InheritedWidget (manual)
   @override
   bool updateShouldNotify(MyWidget oldWidget) {
     return data != oldWidget.data; // Harus ditulis manual
   }
   
   // InheritedNotifier (otomatis)
   // Tidak perlu updateShouldNotify, otomatis listen ke Listenable
   ```

2. **Integration dengan ValueNotifier**:
   - ValueNotifier implements `Listenable`
   - InheritedNotifier langsung bisa listen ke ValueNotifier
   - Saat `notifier.value` berubah, otomatis trigger rebuild

3. **Reactive State Management**:
   ```dart
   // Update data
   planNotifier.value = newPlan;  
   // ↓
   // InheritedNotifier detect perubahan
   // ↓
   // Notify semua dependent widgets
   // ↓
   // ValueListenableBuilder rebuild
   ```

4. **Less Boilerplate Code**:
   - Tidak perlu implement `updateShouldNotify()`
   - Tidak perlu manual notification logic
   - Cukup extends InheritedNotifier dan pass Listenable

5. **Best Practice untuk State Management**:
   - Standard pattern di Flutter
   - Digunakan oleh package populer (Provider, Riverpod)
   - Mudah di-test dan di-maintain

**Analogi Sederhana:**

- **InheritedWidget** = Radio pemancar manual (harus tekan tombol broadcast)
- **InheritedNotifier** = Radio otomatis (otomatis broadcast saat ada perubahan)

Karena aplikasi butuh reactive state yang update otomatis saat data berubah, maka **InheritedNotifier** yang digunakan.

---

#### Soal 3: Maksud Method di Langkah 3

**Method yang ditambahkan di langkah 3:**

```dart
int get completedCount => tasks.where((task) => task.complete).length;

String get completenessMessage =>
    '$completedCount out of ${tasks.length} tasks';
```

**Penjelasan Detail:**

**1. Method `completedCount`:**

```dart
int get completedCount => tasks.where((task) => task.complete).length;
```

**Breakdown:**
- **`int get`**: Getter method yang return integer
- **`tasks.where(...)`**: Filter collection tasks
- **`(task) => task.complete`**: Kondisi filter - ambil task yang complete = true
- **`.length`**: Hitung jumlah hasil filter

**Contoh:**
```dart
// tasks = [
//   Task(description: "A", complete: true),
//   Task(description: "B", complete: false),
//   Task(description: "C", complete: true),
// ]

completedCount // return 2 (task A dan C)
```

---

**2. Method `completenessMessage`:**

```dart
String get completenessMessage =>
    '$completedCount out of ${tasks.length} tasks';
```

**Breakdown:**
- **`String get`**: Getter method yang return String
- **`$completedCount`**: Interpolasi dari method completedCount
- **`${tasks.length}`**: Total jumlah tasks
- **Format**: "X out of Y tasks"

**Contoh:**
```dart
// Jika completedCount = 2, tasks.length = 5
completenessMessage // return "2 out of 5 tasks"

// Jika completedCount = 0, tasks.length = 3
completenessMessage // return "0 out of 3 tasks"

// Jika completedCount = 5, tasks.length = 5
completenessMessage // return "5 out of 5 tasks"
```

---

**Mengapa dilakukan demikian?**

**1. Computed Property Pattern:**
- Nilai dihitung on-the-fly saat diakses
- Tidak perlu store di variable terpisah
- Selalu return nilai terbaru berdasarkan data tasks

```dart
// Tanpa getter (manual update)
class Plan {
  int completedCount = 0;  // Harus diupdate manual setiap kali tasks berubah
  
  void updateTask() {
    // ...
    completedCount = ...;  // Ribet, bisa lupa update
  }
}

// Dengan getter (otomatis)
class Plan {
  int get completedCount => ...;  // Otomatis calculate saat diakses
}
```

**2. Single Responsibility Principle:**
- Class `Plan` tanggung jawab menyimpan data
- Getter tanggung jawab compute derived state
- View hanya display data, tidak ada business logic

**3. Reactive Updates:**
```dart
// Di UI
Text(plan.completenessMessage)  // Otomatis update saat plan berubah
```

Saat `plan` berubah (task ditambah/dicentang):
1. ValueNotifier notify listeners
2. ValueListenableBuilder rebuild
3. `plan.completenessMessage` dipanggil
4. Hitung ulang dengan data terbaru
5. UI tampilkan nilai baru

**4. Clean Code:**
```dart
// Tanpa method (logic di UI - BAD)
Text('${tasks.where((t) => t.complete).length} out of ${tasks.length} tasks')

// Dengan method (clean - GOOD)
Text(plan.completenessMessage)
```

**5. Reusability:**
- Method bisa dipanggil di mana saja
- Tidak perlu copy-paste logic
- Mudah di-test

```dart
// Test
test('completenessMessage format', () {
  final plan = Plan(tasks: [
    Task(complete: true),
    Task(complete: false),
    Task(complete: true),
  ]);
  
  expect(plan.completenessMessage, '2 out of 3 tasks');
});
```

**6. Encapsulation:**
- Business logic ada di model
- View tidak perlu tahu cara hitung completed tasks
- Jika logic berubah, cukup edit di satu tempat

---



Seperti toko yang menghitung **persentase diskon**:

```dart
class Product {
  double price;
  double discount;
  
  // Computed property
  double get finalPrice => price - (price * discount);
  String get priceLabel => 'Rp ${finalPrice.toStringAsFixed(0)}';
}
```

Store `finalPrice` di variable terpisah karena:
- Bisa berubah saat `price` atau `discount` berubah
- Lebih mudah calculate on-demand
- Hindari data inconsistency

**Kesimpulan:**

Method di langkah 3 menggunakan **Computed Property Pattern** untuk:
- Otomatis calculate derived state
- Keep code clean dan maintainable
- Reactive update saat data berubah
- Encapsulation business logic di model
- Reusable dan testable

---

#### Soal 4: Capture Hasil Langkah 9


**Apa yang Telah Dibuat:**

Pada Langkah 9, saya telah mengimplementasikan **ValueListenableBuilder** di method `build()` dengan struktur berikut:

![Praktikum 2 Demo](./img/praktikum2_demo.gif)

**1. Struktur UI Baru:**

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Master Plan Ahmad Fadlih')),
    body: ValueListenableBuilder<Plan>(
      valueListenable: PlanProvider.of(context),
      builder: (context, plan, child) {
        return Column(
          children: [
            Expanded(child: _buildList(plan)),
            SafeArea(child: Text(plan.completenessMessage))
          ],
        );
      },
    ),
    floatingActionButton: _buildAddTaskButton(context),
  );
}
```

**2. Komponen yang Dibuat:**

**a. ValueListenableBuilder:**
- **Purpose**: Widget listener yang rebuild otomatis saat ValueNotifier berubah
- **valueListenable**: `PlanProvider.of(context)` - sumber data yang di-observe
- **builder**: Callback function yang dipanggil setiap kali data update
- **Parameter `plan`**: Data terbaru dari ValueNotifier

**Cara Kerja:**
```
User Action (tap checkbox/add task)
         ↓
planNotifier.value = newPlan
         ↓
ValueNotifier notify listeners
         ↓
ValueListenableBuilder detect change
         ↓
builder() function dipanggil dengan plan baru
         ↓
UI rebuild dengan data terbaru
```

**b. Column Layout:**
- **Purpose**: Vertical layout untuk mengatur List dan Footer
- **Children**: 2 widget (Expanded + SafeArea)

**c. Expanded Widget:**
- **Purpose**: Membuat ListView mengisi semua ruang tersisa
- **Kenapa perlu?** Tanpa Expanded:
  ```
  [ListView]  ← Tidak tahu berapa tingginya
  [Footer]    ← Bisa overflow
  ```
  
  Dengan Expanded:
  ```
  [ListView - flexible, isi ruang tersisa]
  [Footer - fixed di bawah]
  ```

**d. SafeArea:**
- **Purpose**: Menghindari area unsafe di device (notch, home indicator, status bar)
- **Content**: `Text(plan.completenessMessage)`
- **Contoh output**: "2 out of 5 tasks"

**3. Flow Data Reaktif:**

```
Initial State: 0 tasks
  └─ UI: "0 out of 0 tasks"

User tap FAB (+)
  └─ planNotifier.value = Plan(tasks: [Task()])
      └─ ValueListenableBuilder rebuild
          └─ UI: "0 out of 1 tasks"

User centang checkbox
  └─ planNotifier.value = Plan(tasks: [Task(complete: true)])
      └─ ValueListenableBuilder rebuild
          └─ UI: "1 out of 1 tasks"

User tambah 2 task lagi
  └─ planNotifier.value = Plan(tasks: [Task(), Task(), Task()])
      └─ ValueListenableBuilder rebuild
          └─ UI: "1 out of 3 tasks"
```

**4. Perbedaan dengan Praktikum 1:**

| Aspek | Praktikum 1 | Praktikum 2 (Langkah 9) |
|-------|-------------|------------------------|
| **Body Structure** | `_buildList()` saja | `ValueListenableBuilder` dengan Column |
| **Footer** | Tidak ada | Ada SafeArea dengan progress |
| **Data Source** | `plan` variable lokal | `PlanProvider.of(context)` |
| **Rebuild Mechanism** | `setState()` manual | ValueNotifier otomatis |
| **State Location** | Di State class | Di Provider (level lebih tinggi) |

**5. Keuntungan Implementasi Ini:**

**Reactive UI**: Otomatis update tanpa setState()
```dart
// Tidak perlu lagi:
setState(() { plan = newPlan; });

// Cukup:
planNotifier.value = newPlan;  // ValueListenableBuilder otomatis rebuild
```

**Efficient Rebuild**: Hanya widget dalam builder yang rebuild
```dart
// Widget di luar ValueListenableBuilder (AppBar, FAB) tidak rebuild
// Hanya Column dan isinya yang rebuild saat data berubah
```

**Visual Feedback**: User bisa lihat progress task completion
```dart
"0 out of 5 tasks"  // Belum mulai
"3 out of 5 tasks"  // Sedang progress
"5 out of 5 tasks"  // Selesai semua
```

**Clean Architecture**: Separation of concerns jelas
```dart
Model (Plan)  →  Provider (PlanProvider)  →  View (ValueListenableBuilder)
```



---

**Kesimpulan Langkah 9:**

Langkah 9 adalah refactoring Praktikum 2, di mana berhasil:
- Implementasi ValueListenableBuilder untuk reactive UI
- Tambahkan progress counter di footer
- Pisahkan state dari view (separation of concerns)
- Buat UI yang otomatis update tanpa setState manual
- Improve user experience dengan visual feedback


---

### Kesimpulan Praktikum 2

Praktikum 2 berhasil mengimplementasikan state management yang lebih baik dengan:

**InheritedNotifier**: Widget untuk data sharing ke children  
**ValueNotifier**: Reactive state container  
**ValueListenableBuilder**: Auto-rebuild widget saat state berubah  
**Separation of Concerns**: Model, Provider, View terpisah jelas  
**Scalable Architecture**: Mudah dikembangkan untuk fitur baru  
**Progress Tracking**: UI footer menampilkan task completion  

**Perbedaan dengan Praktikum 1:**
- Tidak ada lagi `setState()` di PlanScreen
- State dikelola di level lebih tinggi (PlanProvider)
- UI lebih reactive dengan ValueListenableBuilder
- Kode lebih modular dan testable

---

## Praktikum 3: Membuat State di Multiple Screens

### Tujuan Praktikum
Praktikum 3 ini bertujuan untuk mengimplementasikan konsep **"Lift State Up"** dalam Flutter dengan mengelola state di multiple screens. Kita akan menambahkan screen kedua yang memungkinkan pembuatan multiple plans, sehingga aplikasi Master Plan dapat mengelola lebih dari satu kelompok daftar plan.

---

### Konsep "Lift State Up"

**"Lift State Up"** adalah prinsip populer dalam Flutter yang menyatakan bahwa objek State seharusnya berada lebih tinggi dari widget yang membutuhkannya di dalam widget tree.

**Mengapa perlu Lift State Up?**
1. **Data Sharing**: Multiple screens perlu akses ke data yang sama
2. **Single Source of Truth**: Satu sumber data untuk seluruh aplikasi
3. **Consistency**: Perubahan di satu screen langsung terlihat di screen lain
4. **Scalability**: Mudah menambah screen baru yang akses data yang sama

**Implementasi di Aplikasi:**
```
PlanProvider (root)
    └── MaterialApp
        ├── PlanCreatorScreen (list all plans)
        └── PlanScreen (detail plan)
```

---

### Perubahan dari Praktikum 2 ke Praktikum 3

| Aspek | Praktikum 2 | Praktikum 3 |
|-------|-------------|-------------|
| **State Type** | `ValueNotifier<Plan>` | `ValueNotifier<List<Plan>>` |
| **Screens** | 1 screen (PlanScreen) | 2 screens (PlanCreatorScreen + PlanScreen) |
| **Data Scope** | Single plan | Multiple plans |
| **Navigation** | Tidak ada | Navigator.push ke detail |
| **Home Screen** | Langsung PlanScreen | PlanCreatorScreen (list) |

---

### Struktur Project Praktikum 3

```
lib/
├── models/
│   ├── task.dart          
│   ├── plan.dart          
│   └── data_layer.dart    
├── provider/
│   └── plan_provider.dart # Updated: ValueNotifier<List<Plan>>
├── views/
│   ├── plan_creator_screen.dart  # NEW: Home screen untuk list plans
│   └── plan_screen.dart          # Updated: Menerima parameter plan
└── main.dart                     # Updated: Home = PlanCreatorScreen
```

---

### Penjelasan Langkah-Langkah

#### Langkah 1: Edit PlanProvider

**File**: `lib/provider/plan_provider.dart`

**Perubahan:**
```dart
// Sebelum (Praktikum 2)
class PlanProvider extends InheritedNotifier<ValueNotifier<Plan>> {
  static ValueNotifier<Plan> of(BuildContext context) { ... }
}

// Sesudah (Praktikum 3)
class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  const PlanProvider({
    super.key, 
    required Widget child, 
    required ValueNotifier<List<Plan>> notifier
  }) : super(child: child, notifier: notifier);

  static ValueNotifier<List<Plan>> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }
}
```

**Penjelasan:**
- **`ValueNotifier<List<Plan>>`**: Sekarang mengelola list of plans, bukan single plan
- Return type method `of()` berubah menjadi `ValueNotifier<List<Plan>>`
- Memungkinkan multiple plans diakses dari mana saja di widget tree

---

#### Langkah 2: Edit main.dart

**Perubahan:**
```dart
@override
Widget build(BuildContext context) {
  return PlanProvider(
    notifier: ValueNotifier<List<Plan>>(const []),  // Empty list
    child: MaterialApp(
      title: 'State management app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PlanCreatorScreen(),  // Home screen berubah
    ),
  );
}
```

**Penjelasan:**
- **`const []`**: Inisialisasi dengan empty list (tidak ada plan saat awal)
- **`PlanProvider` di luar `MaterialApp`**: Agar bisa diakses dari semua route
- **`home: const PlanCreatorScreen()`**: Screen utama untuk list plans

---

#### Langkah 3-5: Edit plan_screen.dart

**Tambahan di class PlanScreen:**
```dart
class PlanScreen extends StatefulWidget {
  final Plan plan;  // Parameter plan yang akan ditampilkan
  const PlanScreen({super.key, required this.plan});
  
  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;  // Getter untuk akses plan
  // ...
}
```

**Penjelasan:**
- **`final Plan plan`**: Screen sekarang menerima plan spesifik sebagai parameter
- **`get plan => widget.plan`**: Shortcut untuk akses plan dari state
- **Kenapa perlu parameter?**: Karena sekarang ada multiple plans, screen perlu tahu plan mana yang ditampilkan

---

#### Langkah 6-8: Update Methods di plan_screen.dart

**Method build() yang diupdate:**
```dart
@override
Widget build(BuildContext context) {
  ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

  return Scaffold(
    appBar: AppBar(title: Text(plan.name)),  // Nama plan di AppBar
    body: ValueListenableBuilder<List<Plan>>(
      valueListenable: plansNotifier,
      builder: (context, plans, child) {
        // Cari plan yang sesuai dari list
        Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
        return Column(
          children: [
            Expanded(child: _buildList(currentPlan)),
            SafeArea(child: Text(currentPlan.completenessMessage)),
          ],
        );
      },
    ),
    floatingActionButton: _buildAddTaskButton(context),
  );
}
```

**Penjelasan:**
- **`ValueNotifier<List<Plan>>`**: Tipe berubah dari `Plan` menjadi `List<Plan>`
- **`plans.firstWhere((p) => p.name == plan.name)`**: Mencari plan spesifik dari list
- **`Text(plan.name)`**: AppBar menampilkan nama plan

---

**Method _buildAddTaskButton() yang diupdate:**
```dart
Widget _buildAddTaskButton(BuildContext context) {
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
  return FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      Plan currentPlan = plan;
      // Cari index plan di list
      int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name);
      
      // Update tasks dari plan tersebut
      List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
        ..add(const Task());
      
      // Update list plans dengan plan yang sudah dimodifikasi
      planNotifier.value = List<Plan>.from(planNotifier.value)
        ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
    },
  );
}
```

**Penjelasan:**
1. **`indexWhere()`**: Cari index plan di list berdasarkan name
2. **`List<Task>.from(currentPlan.tasks)..add()`**: Buat copy tasks + tambah task baru
3. **`List<Plan>.from(planNotifier.value)..[planIndex] = ...`**: Update plan di index tertentu
4. **Immutability**: Selalu buat copy baru, jangan modify langsung

---

**Method _buildTaskTile() yang diupdate:**
```dart
Widget _buildTaskTile(Task task, int index, BuildContext context) {
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

  return ListTile(
    leading: Checkbox(
      value: task.complete,
      onChanged: (selected) {
        Plan currentPlan = plan;
        int planIndex = planNotifier.value
            .indexWhere((p) => p.name == currentPlan.name);
        
        // Update task di plan tertentu
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
                name: currentPlan.name,
                tasks: List<Task>.from(currentPlan.tasks)
                  ..[index] = Task(
                        description: task.description,
                        complete: selected ?? false,
                      ),
              );
      }
    ),
    title: TextFormField(
      initialValue: task.description,
      onChanged: (text) {
        Plan currentPlan = plan;
        int planIndex = planNotifier.value
            .indexWhere((p) => p.name == currentPlan.name);
        
        // Update deskripsi task
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
                name: currentPlan.name,
                tasks: List<Task>.from(currentPlan.tasks)
                  ..[index] = Task(
                        description: text,
                        complete: task.complete,
                      ),
              );
      },
    ),
  );
}
```

**Penjelasan:**
- Pattern yang sama: cari index plan → update task → update list plans
- Nested immutability: copy list plans → copy list tasks → update task
- Setiap perubahan trigger rebuild karena ValueNotifier

---

#### Langkah 9-14: Buat PlanCreatorScreen

**File**: `lib/views/plan_creator_screen.dart`

**Struktur Class:**
```dart
class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();
  
  // Layout utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master Plans Fadlih')),
      body: Column(children: [
        _buildListCreator(),        // TextField untuk input plan
        Expanded(child: _buildMasterPlans())  // List plans
      ]),
    );
  }
  
  // Cleanup controller
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  
  // ... methods lainnya
}
```

---

**Widget _buildListCreator():**
```dart
Widget _buildListCreator() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Material(
      color: Theme.of(context).cardColor,
      elevation: 10,  // Shadow effect
      child: TextField(
        controller: textController,
        decoration: const InputDecoration(
          labelText: 'Add a plan',
          contentPadding: EdgeInsets.all(20)
        ),
        onEditingComplete: addPlan,  // Submit saat enter/done
      ),
    ),
  );
}
```

**Penjelasan:**
- **Material dengan elevation**: Memberikan shadow untuk visual depth
- **TextField dengan controller**: Input untuk nama plan baru
- **onEditingComplete**: Dipanggil saat user tekan enter atau done

---

**Method addPlan():**
```dart
void addPlan() {
  final text = textController.text;
  if (text.isEmpty) {
    return;  // Validasi: tidak boleh kosong
  }
  
  // Buat plan baru
  final plan = Plan(name: text, tasks: []);
  
  // Ambil notifier dan tambahkan plan
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
  planNotifier.value = List<Plan>.from(planNotifier.value)..add(plan);
  
  // Reset input dan keyboard
  textController.clear();
  FocusScope.of(context).requestFocus(FocusNode());
  setState(() {});
}
```

**Penjelasan:**
1. **Validasi**: Cek text tidak kosong
2. **Create Plan**: Plan baru dengan name dari input dan empty tasks
3. **Update State**: Tambahkan plan ke list
4. **Reset UI**: Clear textfield dan dismiss keyboard
5. **setState()**: Trigger rebuild (walaupun ValueNotifier juga akan trigger)

---

**Widget _buildMasterPlans():**
```dart
Widget _buildMasterPlans() {
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
  List<Plan> plans = planNotifier.value;

  // Empty state
  if (plans.isEmpty) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.note, size: 100, color: Colors.grey),
        Text('Anda belum memiliki rencana apapun.',
            style: Theme.of(context).textTheme.headlineSmall)
      ],
    );
  }
  
  // List plans
  return ListView.builder(
    itemCount: plans.length,
    itemBuilder: (context, index) {
      final plan = plans[index];
      return ListTile(
        title: Text(plan.name),
        subtitle: Text(plan.completenessMessage),  // Progress counter
        onTap: () {
          // Navigate ke detail plan
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PlanScreen(plan: plan)
            )
          );
        },
      );
    },
  );
}
```

**Penjelasan:**
- **Empty State**: Tampilan ketika belum ada plan (icon + text)
- **ListView.builder**: Render list plans secara efficient
- **ListTile**: Item plan dengan title (name) dan subtitle (progress)
- **Navigation**: Push ke PlanScreen dengan passing plan object

---

### Flow Aplikasi Praktikum 3

```
1. App Start
   └─ PlanCreatorScreen (empty state)

2. User Input "Shopping List" + Enter
   └─ addPlan() dipanggil
      └─ Plan baru ditambahkan ke List<Plan>
         └─ ListView rebuild dengan 1 item

3. User Tap "Shopping List"
   └─ Navigator.push(PlanScreen(plan: shoppingPlan))
      └─ PlanScreen menampilkan tasks dari plan tersebut

4. User Tambah Task "Buy milk"
   └─ FAB onPressed
      └─ Update List<Plan> di index plan tersebut
         └─ PlanScreen rebuild dengan task baru

5. User Back ke PlanCreatorScreen
   └─ Navigator.pop()
      └─ Progress "0 out of 1 tasks" terlihat di subtitle
```

---

### Konsep yang Dipelajari

#### 1. State Management Across Screens

**Problem**: Bagaimana share state antara multiple screens?

**Solution**: Lift state ke parent (PlanProvider di root)

```dart
// State di root
PlanProvider(
  notifier: ValueNotifier<List<Plan>>(const []),
  child: MaterialApp(...),
)

// Akses dari screen manapun
ValueNotifier<List<Plan>> plans = PlanProvider.of(context);
```

---

#### 2. Navigation dengan Data Passing

**Push dengan parameter:**
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => PlanScreen(plan: selectedPlan)
  )
);
```

**Receive di destination:**
```dart
class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});
}
```

---

#### 3. Updating Nested Immutable Data

**Challenge**: Update task di plan tertentu di list of plans

**Pattern:**
```dart
// 1. Cari index plan
int planIndex = plans.indexWhere((p) => p.name == targetPlan.name);

// 2. Copy list plans
List<Plan> newPlans = List<Plan>.from(plans);

// 3. Copy list tasks
List<Task> newTasks = List<Task>.from(targetPlan.tasks);

// 4. Update task
newTasks[taskIndex] = updatedTask;

// 5. Update plan
newPlans[planIndex] = Plan(name: targetPlan.name, tasks: newTasks);

// 6. Assign ke notifier
planNotifier.value = newPlans;
```

**Shorthand dengan cascade:**
```dart
planNotifier.value = List<Plan>.from(plans)
  ..[planIndex] = Plan(
        name: targetPlan.name,
        tasks: List<Task>.from(tasks)
          ..[taskIndex] = updatedTask,
      );
```

---

#### 4. Empty State Pattern

**UI untuk kondisi data kosong:**
```dart
if (data.isEmpty) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.note, size: 100, color: Colors.grey),
      Text('Pesan empty state', style: ...)
    ],
  );
}
return ListView.builder(...);
```

**Best Practice:**
- Gunakan icon yang relevan dengan context
- Text yang jelas dan friendly
- Consider tambah action button (e.g., "Create First Plan")

---

### Perbandingan Pattern State Management

#### Praktikum 2: Single Screen
```dart
// State
ValueNotifier<Plan> planNotifier;

// Access
Plan currentPlan = planNotifier.value;

// Update
planNotifier.value = Plan(name: ..., tasks: ...);
```

#### Praktikum 3: Multiple Screens
```dart
// State
ValueNotifier<List<Plan>> plansNotifier;

// Access
int index = plans.indexWhere((p) => p.name == targetName);
Plan currentPlan = plans[index];

// Update
plansNotifier.value = List<Plan>.from(plans)
  ..[index] = updatedPlan;
```

---

### Screenshot Aplikasi

#### 1. Home Screen (PlanCreatorScreen)
![Plan Creator Home](./img/praktikum3_home.gif)

**Fitur yang Ditampilkan:**
- AppBar dengan title "Master Plan" (warna purple)
- TextField "Add a plan" dengan Material elevation
- Empty state dengan icon dan text "Anda belum memiliki rencana apapun"
- ListView menampilkan list plans dengan title dan subtitle (progress counter)

---

#### 2. Create New Plan
![Create Plan](./img/praktikum3_create_plan.gif)

**Fitur yang Ditampilkan:**
- User mengetik nama plan di TextField
- Press Enter/Done → plan ditambahkan ke list
- TextField otomatis clear setelah submit
- Plan baru muncul di ListView dengan subtitle "0 out of 0 tasks"

---

#### 3. Navigation ke Detail
![Navigation](./img/praktikum3_navigation.gif)

**Fitur yang Ditampilkan:**
- Tap plan → Navigate ke PlanScreen
- Detail screen menampilkan tasks dari plan tersebut
- Tambah tasks dengan FAB (+)
- Edit task description
- Centang checkbox → progress counter update
- Back arrow → kembali ke home
- Subtitle di home screen update dengan progress terbaru

---

### Cara Menjalankan Aplikasi

1. Pastikan Praktikum 2 sudah selesai
2. Jalankan aplikasi:
   ```bash
   cd codelab10/master_plan
   flutter run
   ```
3. **Testing Flow:**
   - Tambah beberapa plans (e.g., "Shopping", "Work", "Personal")
   - Tap salah satu plan untuk masuk ke detail
   - Tambah tasks di plan tersebut
   - Centang beberapa tasks
   - Back ke home → lihat progress update
   - Masuk ke plan lain → tasks tetap terpisah per plan

---

### Kesimpulan Praktikum 3

Praktikum ini berhasil mengimplementasikan:
-  **Multiple Screens**: PlanCreatorScreen + PlanScreen
-  **Lift State Up**: State di root level (PlanProvider)
-  **List State Management**: ValueNotifier<List<Plan>>
-  **Navigation**: Push/Pop dengan parameter
-  **Nested Immutable Updates**: Update task dalam plan dalam list
-  **Empty State**: UI untuk kondisi no data
-  **Data Persistence**: State tetap konsisten across screens

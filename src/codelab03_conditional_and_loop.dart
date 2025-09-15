void main() {
  // ===========================================
  // Praktikum 1: Menerapkan Control Flows (if/else)
  // ===========================================
  print('=== Praktikum 1: if/else ===\n');

  // Contoh if/else if/else
  String test = "test2";
  if (test == "test1") {
    print("Test1");
  } else if (test == "test2") {
    print("Test2");
  } else {
    print("Something else");
  }

  // Contoh if tanpa kurung kurawal
  if (test == "test2") print("Test2 again");

  // Perbaikan kode yang salah (dari soal lain)
  String test2 = "true";
  if (test2 == "true") { // Memperbaiki kesalahan dengan membandingkan string
    print("Kebenaran");
  }

  print('\n' + '=' * 40 + '\n');

  // ===========================================
  // Praktikum 2: Menerapkan Perulangan (while dan do-while)
  // ===========================================
  print('=== Praktikum 2: while & do-while ===\n');

  // Perbaikan while loop yang salah (menambahkan inisialisasi)
  int counter = 0;
  while (counter < 33) {
    print(counter);
    counter++;
  }

  // Perbaikan do-while loop (melanjutkan dari nilai counter sebelumnya)
  do {
    print(counter);
    counter++;
  } while (counter < 77);

  print('\n' + '=' * 40 + '\n');

  // ===========================================
  // Praktikum 3: Menerapkan Perulangan (for dan break/continue)
  // ===========================================
  print('=== Praktikum 3: for & break/continue ===\n');

  // Perbaikan for loop yang salah (masalah case-sensitivity)
  for (int index = 10; index < 27; index++) {
    print(index);
  }

  // Penerapan break dan continue
  for (int index = 10; index < 27; index++) {
    if (index == 21) {
      break; // Menghentikan perulangan saat index mencapai 21
    }
    // Kondisi berikut tidak akan pernah terpenuhi, tapi kode tetap benar secara sintaks
    if (index > 1 || index < 7) {
      continue;
    }
    print(index);
  }

  print('\n' + '=' * 40 + '\n');

  // ===========================================
  // Tugas Tambahan: Program Bilangan Prima
  // ===========================================
  print('=== Tugas Tambahan: Bilangan Prima ===\n');

  String nama = "Ahmad Fadlih Wahyu Sardana"; 
  String nim = "2341720069";           

  print('Mencari bilangan prima dari 0 sampai 201...');

  for (int i = 2; i <= 201; i++) {
    if (isPrima(i)) {
      print('Bilangan prima ditemukan: $i');
      print('Nama: $nama');
      print('NIM: $nim');
      print('---');
    }
  }
}

// Fungsi pembantu untuk mengecek apakah sebuah bilangan adalah prima
bool isPrima(int number) {
  if (number <= 1) {
    return false;
  }
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}
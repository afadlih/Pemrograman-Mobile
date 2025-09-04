// Kode ini menunjukkan Null Safety dan Late Variabel
void main() {
  // Contoh Null Safety:
  String? namaBelakang; // Variabel ini bisa null
  // print(namaBelakang.length); // Error! Karena variabel bisa null

  // Kita harus menggunakan null-aware operator untuk mengakses length
  print('Panjang nama belakang: ${namaBelakang?.length ?? "Variabel namaBelakang adalah null."}');

  // Contoh Late Variabel:
  late String deskripsiProduk;
  
  // Asumsikan di sini ada operasi yang membutuhkan waktu
  // dan baru bisa menginisialisasi variabel
  deskripsiProduk = 'Produk terbaru dengan fitur inovatif.';
  
  // Karena sudah diinisialisasi, variabel 'deskripsiProduk' aman untuk digunakan
  print(deskripsiProduk);
}
# PyFL_Lara-PredictIWAK
langkah-langkah untuk membangun aplikasi prediksi penjualan ikan tongkol dengan Python (machine learning), MongoDB (database), Laravel (backend + frontend prediksi), dan Flutter (mobile input data):
1. Persiapan Lingkungan
Python: Install Anaconda atau virtual environment dan pustaka yang dibutuhkan (pandas, scikit-learn, flask, pymongo).
MongoDB: Setup database di MongoDB Atlas (cloud) atau lokal.
Laravel: Install Laravel dan package untuk koneksi MongoDB (jenssegers/mongodb).
Flutter: Setup Flutter SDK dan proyek Flutter.
2. Pembuatan Model Prediksi (Python)
Persiapan Data:

Kumpulkan data historis penjualan ikan tongkol (misalnya harga, volume penjualan, cuaca, dll.).
Simpan di MongoDB.
Pengolahan Data & Training Model:

Gunakan pandas untuk membaca data dari MongoDB.
Gunakan scikit-learn untuk pemrosesan dan pembuatan model (misalnya regresi linear, random forest, atau LSTM jika menggunakan time series).
Simpan model dengan joblib atau pickle.
Pembuatan API Python (Flask/FastAPI):

Buat endpoint /predict yang menerima data input dari Laravel.
Load model dan lakukan prediksi.
Kirim hasil prediksi ke Laravel dalam format JSON.

Cara Menjalankan
Langkah 1: Melatih Model LSTM
Jalankan perintah berikut di terminal (pindah ke scripts/ dulu):

python train_model.py
Ini akan menyimpan model ke folder models/.

Langkah 2: Menjalankan API Flask
Setelah model selesai dilatih, jalankan API Flask:

python api.py
Flask akan berjalan di http://127.0.0.1:5000/.

Langkah 3: Menggunakan API
Untuk menguji API, kirim permintaan dengan Postman atau menggunakan curl:
curl -X POST http://127.0.0.1:5000/predict \
     -H "Content-Type: application/json" \
     -d '{"harga": 15000, "volume": 200}'

3. Backend Laravel untuk Prediksi
Setup Laravel & Konfigurasi MongoDB:

Install jenssegers/mongodb.
Konfigurasi .env untuk koneksi ke MongoDB.
Buat API untuk Menampilkan Prediksi:

Buat route di api.php untuk menangkap request prediksi.
Buat controller untuk mengirimkan data ke API Python.
Tampilkan hasil prediksi di frontend Laravel.
4. Aplikasi Flutter untuk Input Data
Setup Proyek Flutter

Gunakan Flutter versi terbaru.
Install package http, provider, dan mongo_dart untuk koneksi MongoDB.
CRUD Data Penjualan:

Buat halaman input data penjualan (harga, volume, faktor lain).
Implementasi CRUD ke MongoDB dengan API Laravel.
5. Testing & Deployment
Testing API: Gunakan Postman untuk mengecek API Python dan Laravel.
Testing Mobile: Jalankan aplikasi Flutter untuk memastikan input tersimpan dengan benar.
Deployment:
Deploy Flask API di VPS/Heroku.
Deploy Laravel di server dengan MongoDB support.
Deploy aplikasi Flutter ke Play Store.

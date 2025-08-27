# Absensi Pegawai – PT Nikel Arta Gemilang

Aplikasi mobile untuk mencatat kehadiran pegawai berbasis lokasi (geofencing) dan **selfie kamera depan**. Fokus pada proses **Check In / Check Out** yang cepat dan akurat.

> Dokumen ini menjelaskan **fitur & alur aplikasi** (bukan teknis instalasi).

---

## Daftar Isi

- [Ringkasan Fitur (yang ada)](#ringkasan-fitur-yang-ada)
- [Alur Penggunaan](#alur-penggunaan)
- [Layar Utama](#layar-utama)
- [Data yang Dicatat / Dikirim](#data-yang-dicatat--dikirim)
- [Izin yang Dibutuhkan](#izin-yang-dibutuhkan)
- [Batasan yang Diketahui](#batasan-yang-diketahui)
- [Keamanan & Privasi (ringkas)](#keamanan--privasi-ringkas)
- [Screenshot](#screenshot)
- [Demo Video](#demo-video)

---

## Ringkasan Fitur (yang ada)

### Login & Manajemen Sesi

- Login dengan token; **refresh token otomatis (silent)** ketika akses kedaluwarsa.

### Geofencing

- Tampilkan status **di dalam/luar area**, jarak ke kantor (meter), dan **radius kantor**.

### Check In / Check Out dengan Selfie

- **Wajib kamera depan** dengan preview & tombol **Ulang**.
- Foto otomatis **dikompresi (maks 1080px)** dan dikirim **base64** ke server.

### Status Hari Ini

- Menampilkan **tanggal kerja**, **radius**, **jarak**, dan **waktu Check In / Check Out** yang sudah tercatat.

### Kalender Kehadiran

- Tanggal yang sudah absen diberi **marker**.
- Ketuk tanggal untuk melihat **riwayat hari itu** (waktu Check In & Check Out).

### Loading & Error

- **Shimmer** untuk skeleton pada bagian riwayat/kalender.
- Pesan error yang jelas (mis. **di luar radius**, **sudah check in**, **koneksi bermasalah**).

---

## Alur Penggunaan

### Masuk

- Pengguna login, aplikasi meminta izin **Lokasi** & **Kamera**.

### Check In

1. Sistem cek lokasi terhadap **radius kantor**.
2. Jika dalam radius → buka **kamera depan** → ambil selfie (bisa **Ulang**) → kirim.
3. Tersimpan **waktu masuk**, **koordinat**, dan **foto**.

### Check Out

1. Proses sama dengan Check In (**radius + selfie**).
2. Tersimpan **waktu pulang**, **koordinat**, dan **foto**.

### Kalender & Riwayat

- Tanggal yang memiliki absensi diberi **marker**.
- Ketuk tanggal → tampil **waktu Check In / Check Out** (jika ada).

---

## Layar Utama

### Login

- Form sederhana, tampil **loading** & **pesan error** ketika gagal.

### Dashboard / Status

- **Status**: di dalam/luar area.
- **Hari ini**: tanggal, **radius kantor (m)**, **jarak ke kantor (m)**.
- **Waktu**: Check In & Check Out (jika ada).
- **Aksi**: tombol **Check In / Check Out** aktif sesuai kondisi.

### Kalender

- Navigasi bulan (← →).
- **Marker** di tanggal yang ada absensi.
- **Panel Riwayat Hari**: daftar waktu Check In /

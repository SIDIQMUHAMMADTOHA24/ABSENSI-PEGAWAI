# Absensi Pegawai – PT Migas Darma Nusantara

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

![WhatsApp Image 2025-08-27 at 18 55 09](https://github.com/user-attachments/assets/a23d1c29-08c8-4b49-84d4-53d76a5a340f)

- Form sederhana, tampil **loading** & **pesan error** ketika gagal.

### Dashboard / Status
![WhatsApp Image 2025-08-27 at 18 55 09 (2)](https://github.com/user-attachments/assets/6b6a1d04-db40-4f82-a33d-e6b7788ebbca)
![WhatsApp Image 2025-08-27 at 18 55 09 (1)](https://github.com/user-attachments/assets/58badaae-083c-4e8a-b828-5c249c24027f)
![WhatsApp Image 2025-08-27 at 18 55 11](https://github.com/user-attachments/assets/8c9ded09-4803-481d-87f8-dfc0de706f4d)
![WhatsApp Image 2025-08-27 at 18 55 10](https://github.com/user-attachments/assets/c8c7b395-c902-46fc-86e3-bfb230413bb1)

- **Status**: di dalam/luar area.
- **Hari ini**: tanggal, **radius kantor (m)**, **jarak ke kantor (m)**.
- **Waktu**: Check In & Check Out (jika ada).
- **Aksi**: tombol **Check In / Check Out** aktif sesuai kondisi.

### Permission
- **Cuti** user bisa mengajukan cuti, nantinya bakal ada atasan yang approve, history juga akan ditampilkan di bawah form pengajuan
- **Sakit** user bisa mengajukan sakit disertai dengan bukti Surat Keterangan dari dokter, nantinya bakal ada atasan yang approve, history juga akan ditampilkan di bawah form pengajuan
<img width="500" height="1080" alt="Screenshot_1757394765" src="https://github.com/user-attachments/assets/bbd4e1f3-34c2-4362-8d10-58a4656b07db" />
<img width="500" height="1080" alt="Screenshot_1757394760" src="https://github.com/user-attachments/assets/a05ca520-094d-4053-978f-a2a6131b4fa4" />


### Kalender
![WhatsApp Image 2025-08-27 at 18 55 10 (1)](https://github.com/user-attachments/assets/852c827d-343b-4abc-9b7b-579e5ef38bc7)

- Navigasi bulan (← →).
- **Marker** di tanggal yang ada absensi.
- **Panel Riwayat Hari**: daftar waktu Check In /

### Profile
![WhatsApp Image 2025-08-27 at 18 55 10 (2)](https://github.com/user-attachments/assets/1a2848dd-e4aa-457e-b389-c79df8b1406e)


### Demo Aplikasi
https://youtu.be/3PPrm5DDi0Y
> Aplikasi ini murni hanya untuk project mandiri, tidak ada kerjasama dengan pihak manamun

### Aplikasi
https://github.com/SIDIQMUHAMMADTOHA24/ABSENSI-PEGAWAI/releases/download/1.0.0/absensi.apk

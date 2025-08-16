import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // ====== Konfigurasi kantor ====== -7.688360, 110.187415
  static const double officeLat = -7.688360; // ganti sesuai lokasi kantor
  static const double officeLon = 110.187415; // ganti sesuai lokasi kantor
  static const double officeRadiusM = 100; // meter

  // ====== State lokasi & status ======
  double? _curLat;
  double? _curLon;
  double? _distanceM; // jarak user ke titik kantor dalam meter
  bool _inside = false;

  // ====== State absensi ======
  DateTime? _checkInAt;
  DateTime? _checkOutAt;

  StreamSubscription<Position>? _posSub;
  bool _locationReady = false;
  bool _loadingPrefs = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _posSub?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    await _loadPrefs();
    await _ensureLocationPermission();
    await _startLocationStream();
    setState(() => _locationReady = true);
  }

  Future<void> _loadPrefs() async {
    final sp = await SharedPreferences.getInstance();
    final ci = sp.getString('checkInAt');
    final co = sp.getString('checkOutAt');
    setState(() {
      _checkInAt = ci != null ? DateTime.tryParse(ci) : null;
      _checkOutAt = co != null ? DateTime.tryParse(co) : null;
      _loadingPrefs = false;
    });
  }

  Future<void> _savePrefs() async {
    final sp = await SharedPreferences.getInstance();
    if (_checkInAt != null) {
      await sp.setString('checkInAt', _checkInAt!.toIso8601String());
    } else {
      await sp.remove('checkInAt');
    }
    if (_checkOutAt != null) {
      await sp.setString('checkOutAt', _checkOutAt!.toIso8601String());
    } else {
      await sp.remove('checkOutAt');
    }
  }

  Future<void> _ensureLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Minta user nyalakan GPS
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      // Arahkan user ke settings app
      await Geolocator.openAppSettings();
    }
  }

  Future<void> _startLocationStream() async {
    // Ambil posisi awal
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _handlePosition(pos);

    // Dengarkan perubahan posisi (hemat baterai: distanceFilter beberapa meter)
    _posSub?.cancel();
    _posSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen(_handlePosition);
  }

  void _handlePosition(Position p) {
    final d = Geolocator.distanceBetween(
      p.latitude,
      p.longitude,
      officeLat,
      officeLon,
    ); // meter
    setState(() {
      _curLat = p.latitude;
      _curLon = p.longitude;
      _distanceM = d;
      _inside = d <= officeRadiusM;
    });
  }

  Future<void> _onCheckIn() async {
    if (!_inside) return;
    if (_checkInAt != null) return; // sudah check-in
    setState(() {
      _checkInAt = DateTime.now();
      _checkOutAt = null; // reset checkout
    });
    await _savePrefs();
    _snack('Berhasil check-in');
  }

  Future<void> _onCheckOut() async {
    if (_checkInAt == null) return; // belum check-in
    if (_checkOutAt != null) return; // sudah check-out
    setState(() {
      _checkOutAt = DateTime.now();
    });
    await _savePrefs();
    _snack('Berhasil check-out');
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  String _fmt(DateTime? dt) {
    if (dt == null) return '—';
    // Format ringkas lokal (tanpa paket tambahan)
    final d = dt;
    two(int n) => n.toString().padLeft(2, '0');
    return '${d.year}-${two(d.month)}-${two(d.day)} ${two(d.hour)}:${two(d.minute)}:${two(d.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final padTop = MediaQuery.paddingOf(context).top;
    final canCheckIn = _inside && _checkInAt == null;
    final canCheckOut = _checkInAt != null && _checkOutAt == null;

    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Radius'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, padTop + 16, 16, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_loadingPrefs || !_locationReady)
                const CircularProgressIndicator(),
              if (!_loadingPrefs && _locationReady) ...[
                Text("Check In Pada : ${_fmt(_checkInAt)}"),
                const SizedBox(height: 12),
                Text("Check Out Pada : ${_fmt(_checkOutAt)}"),
                const SizedBox(height: 16),
                const Text("Lokasi Anda:"),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Lat : ${_curLat?.toStringAsFixed(6) ?? '—'}"),
                    const SizedBox(width: 12),
                    Text("Long : ${_curLon?.toStringAsFixed(6) ?? '—'}"),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Jarak ke kantor: ${_distanceM != null ? '${_distanceM!.toStringAsFixed(1)} m' : '—'}",
                ),
                const SizedBox(height: 4),
                Chip(
                  label: Text(
                    _inside
                        ? "Di dalam area (≤ ${officeRadiusM.toInt()} m)"
                        : "Di luar area",
                  ),
                  backgroundColor: _inside
                      ? Colors.green.shade100
                      : Colors.red.shade100,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: canCheckIn ? _onCheckIn : null,
                      child: const Text("Check In"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: canCheckOut ? _onCheckOut : null,
                      child: const Text("Check Out"),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text("Lokasi Kantor:"),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Lat : ${officeLat.toStringAsFixed(6)}"),
                    const SizedBox(width: 12),
                    Text("Long : ${officeLon.toStringAsFixed(6)}"),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Radius: ${officeRadiusM.toStringAsFixed(0)} m"),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

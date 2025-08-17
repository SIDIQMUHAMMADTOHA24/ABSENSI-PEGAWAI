import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceRepository {
  static const double officeLat = -7.688260;
  static const double officeLon = 110.187048;
  static const double officeRadiusM = 20;

  StreamSubscription<Position>? _sub;

  Future<void> ensurePermission() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) await Geolocator.openLocationSettings();

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }

  Future<Position> getCurrent() =>
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  Stream<Position> startPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 5,
  }) {
    _sub?.cancel(); // biar nggak dobel kalau dipanggil dua kali
    final controller = StreamController<Position>();
    _sub = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    ).listen(controller.add);
    controller.onCancel = () => _sub?.cancel();
    return controller.stream;
  }

  void stopStream() => _sub?.cancel();

  double distanceToOffice(double lat, double lon) {
    return Geolocator.distanceBetween(lat, lon, officeLat, officeLon);
  }

  Future<(DateTime?, DateTime?)> loadTimes() async {
    final sp = await SharedPreferences.getInstance();
    final ci = sp.getString('checkInAt');
    final co = sp.getString('checkOutAt');
    return (
      ci != null ? DateTime.tryParse(ci) : null,
      co != null ? DateTime.tryParse(co) : null,
    );
  }

  Future<void> saveTimes(DateTime? checkIn, DateTime? checkOut) async {
    final sp = await SharedPreferences.getInstance();
    if (checkIn != null) {
      await sp.setString('checkInAt', checkIn.toIso8601String());
    } else {
      await sp.remove('checkInAt');
    }
    if (checkOut != null) {
      await sp.setString('checkOutAt', checkOut.toIso8601String());
    } else {
      await sp.remove('checkOutAt');
    }
  }
}

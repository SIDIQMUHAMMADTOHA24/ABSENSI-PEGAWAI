import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';
import 'package:geolocator/geolocator.dart';

class LocationLocalDataSource {
  Future<bool> ensurePermission() async {
    var enable = await Geolocator.isLocationServiceEnabled();
    if (!enable) await Geolocator.openLocationSettings();

    var p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }
    if (p == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    return p == LocationPermission.always || p == LocationPermission.whileInUse;
  }

  GeoPos _map(Position position) {
    return GeoPos(
      lat: position.latitude,
      long: position.longitude,
      accuracyM: position.accuracy,
      timestamp: position.timestamp,
    );
  }

  Future<GeoPos> getCurrent() async {
    return _map(
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ),
    );
  }

  Stream<GeoPos> watch({int distanceFilterM = 5}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilterM,
      ),
    ).map(_map);
  }
}

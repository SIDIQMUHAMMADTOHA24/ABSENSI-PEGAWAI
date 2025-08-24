import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';

abstract class LocationRepository {
  Future<bool> ensurePermission();
  Future<GeoPos> getCurrent();
  Stream<GeoPos> watch({int distanceFilterM = 5});
}

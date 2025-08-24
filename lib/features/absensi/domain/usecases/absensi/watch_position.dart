import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/location_repository.dart';

class WatchPosition {
  final LocationRepository repository;

  WatchPosition(this.repository);
  Stream<GeoPos> call({int distanceFilterM = 5}) =>
      repository.watch(distanceFilterM: distanceFilterM);
}

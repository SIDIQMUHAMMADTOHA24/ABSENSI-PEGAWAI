import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/location_repository.dart';

class GetCurrentPos {
  final LocationRepository repository;

  GetCurrentPos(this.repository);
  Future<GeoPos> call() => repository.getCurrent();
}

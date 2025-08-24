import 'package:absensi_pegawai/features/absensi/data/datasources/location_local_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/geo_pos.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource locationLocalDataSource;

  LocationRepositoryImpl(this.locationLocalDataSource);

  @override
  Future<bool> ensurePermission() {
    return locationLocalDataSource.ensurePermission();
  }

  @override
  Future<GeoPos> getCurrent() {
    return locationLocalDataSource.getCurrent();
  }

  @override
  Stream<GeoPos> watch({int distanceFilterM = 5}) {
    return locationLocalDataSource.watch(distanceFilterM: distanceFilterM);
  }
}

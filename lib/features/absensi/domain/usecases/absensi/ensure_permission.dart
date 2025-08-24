import 'package:absensi_pegawai/features/absensi/domain/repositories/location_repository.dart';

class EnsurePermission {
  final LocationRepository repository;

  EnsurePermission(this.repository);
  Future<bool> call() => repository.ensurePermission();
}

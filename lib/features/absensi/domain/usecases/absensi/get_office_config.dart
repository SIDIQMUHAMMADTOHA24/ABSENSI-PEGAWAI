import 'package:absensi_pegawai/features/absensi/domain/entities/office_config.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/office_repository.dart';

class GetOfficeConfig {
  final OfficeRepository repository;

  GetOfficeConfig(this.repository);
  Future<OfficeConfig> call({bool force = false}) =>
      repository.get(forceRefresh: force);
}

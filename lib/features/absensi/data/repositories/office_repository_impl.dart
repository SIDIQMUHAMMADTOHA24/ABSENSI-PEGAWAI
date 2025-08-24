import 'package:absensi_pegawai/features/absensi/data/datasources/office_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/local/office_storage.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/office_config.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/office_repository.dart';

import '../models/office_config_cache_model.dart';
import '../models/office_config_model.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeRemoteDataSource remote;
  final OfficeStorage local;
  final Duration ttl;

  OfficeConfig? _mem;

  OfficeRepositoryImpl({
    required this.remote,
    required this.local,
    required this.ttl,
  });
  @override
  Future<OfficeConfig> get({bool forceRefresh = false}) async {
    final now = DateTime.now();

    if (!forceRefresh &&
        _mem != null &&
        now.difference(_mem!.fetchedAt) < ttl) {
      return _mem!;
    }

    if (!forceRefresh) {
      final cached = await local.readLocation();
      if (cached != null && now.difference(cached.fetchedAt) < ttl) {
        return _mem = cached.toEntity();
      }
    }

    final OfficeConfigModel net = await remote.fetch();
    final entity = net.toEntity(now);

    await local.saveLocation(OfficeConfigCacheModel.fromEntity(entity));
    return _mem = entity;
  }
}

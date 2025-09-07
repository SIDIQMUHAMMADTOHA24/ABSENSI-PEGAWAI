import 'package:absensi_pegawai/features/absensi/data/datasources/cuti_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/quota.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/cuti_repository.dart';

class CutiRepositoryImpl implements CutiRepository {
  final CutiRemoteDataSource cutiRemoteDataSource;

  CutiRepositoryImpl(this.cutiRemoteDataSource);
  @override
  Future<Quota> getQuotaCuti() {
    return cutiRemoteDataSource.getQuotaCuti();
  }

  @override
  Future<List<HistoryCuti>> getHistoryCuti() {
    return cutiRemoteDataSource.getHistoryCuti();
  }

  @override
  Future<bool> addCuti({
    required String reason,
    required String startDate,
    required String endDate,
  }) {
    return cutiRemoteDataSource.addCuti(
      reason: reason,
      startDate: startDate,
      endDate: endDate,
    );
  }
}

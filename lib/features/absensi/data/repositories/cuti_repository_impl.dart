import 'package:absensi_pegawai/features/absensi/data/datasources/cuti_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/quota.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/cuti_repository.dart';

class CutiRepositoryImpl implements CutiRepository {
  final CutiRemoteDataSource cutiRemoteDataSource;

  CutiRepositoryImpl(this.cutiRemoteDataSource);
  @override
  Future<Quota> getQuotaCuti() {
    return cutiRemoteDataSource.getQuotaCuti();
  }
}

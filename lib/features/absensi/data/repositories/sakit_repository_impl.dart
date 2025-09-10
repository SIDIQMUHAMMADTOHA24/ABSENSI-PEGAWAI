import 'package:absensi_pegawai/features/absensi/data/datasources/sakit_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/history_sakit.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/sakit_repository.dart';

class SakitRepositoryImpl implements SakitRepository {
  final SakitRemoteDataSource sakitRemoteDataSource;

  SakitRepositoryImpl(this.sakitRemoteDataSource);
  @override
  Future<List<HistorySakit>> getHistorySakit() =>
      sakitRemoteDataSource.getHistorySakit();

  @override
  Future<bool> addSakit({
    required String reason,
    required String image,
    required String startDate,
    required String endDate,
  }) => sakitRemoteDataSource.addSakit(
    reason: reason,
    image: image,
    startDate: startDate,
    endDate: endDate,
  );
}

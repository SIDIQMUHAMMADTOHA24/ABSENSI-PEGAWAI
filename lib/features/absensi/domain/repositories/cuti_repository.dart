import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/entities/quota.dart';

abstract class CutiRepository {
  Future<Quota> getQuotaCuti();
  Future<List<HistoryCuti>> getHistoryCuti();
  Future<bool> addCuti({
    required String reason,
    required String startDate,
    required String endDate,
  });
}

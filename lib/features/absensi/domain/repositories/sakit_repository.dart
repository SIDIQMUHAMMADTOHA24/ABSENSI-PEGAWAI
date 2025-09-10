import 'package:absensi_pegawai/features/absensi/domain/entities/history_sakit.dart';

abstract class SakitRepository {
  Future<List<HistorySakit>> getHistorySakit();
  Future<bool> addSakit({
    required String reason,
    required String image,
    required String startDate,
    required String endDate,
  });
}

import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/cuti_repository.dart';

class ListHistoryCuti {
  final CutiRepository repository;

  ListHistoryCuti(this.repository);

  Future<List<HistoryCuti>> call() => repository.getHistoryCuti();
}

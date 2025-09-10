import 'package:absensi_pegawai/features/absensi/domain/entities/history_sakit.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/sakit_repository.dart';

class ListHistorySakit {
  final SakitRepository repository;

  ListHistorySakit(this.repository);

  Future<List<HistorySakit>> call() => repository.getHistorySakit();
}

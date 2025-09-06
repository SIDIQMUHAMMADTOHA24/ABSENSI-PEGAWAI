import 'package:absensi_pegawai/features/absensi/domain/entities/quota.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/cuti_repository.dart';

class QuotaCuti {
  final CutiRepository repository;

  QuotaCuti(this.repository);

  Future<Quota> call() => repository.getQuotaCuti();
}

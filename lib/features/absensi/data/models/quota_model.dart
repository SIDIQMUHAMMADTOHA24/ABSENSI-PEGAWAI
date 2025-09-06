import 'package:absensi_pegawai/features/absensi/domain/entities/quota.dart';

class QuotaModel extends Quota {
  QuotaModel({
    required super.year,
    required super.quoraDay,
    required super.usedDay,
    required super.remainingDay,
  });

  factory QuotaModel.fromJson(Map<String, dynamic> j) => QuotaModel(
    year: j['year'] as int,
    quoraDay: j['quota_days'] as int,
    usedDay: j['used_days'] as int,
    remainingDay: j['remaining_days'] as int,
  );
}

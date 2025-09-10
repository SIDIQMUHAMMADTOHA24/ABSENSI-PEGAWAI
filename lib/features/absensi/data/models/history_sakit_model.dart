import 'package:absensi_pegawai/features/absensi/domain/entities/history_sakit.dart';

import 'history_cuti_model.dart';

class HistorySakitModel extends HistorySakit {
  HistorySakitModel({
    required super.status,
    required super.reason,
    required super.startDate,
    required super.endDate,
    required super.createdAt,
    required super.decidedAt,
  });

  factory HistorySakitModel.fromJson(Map<String, dynamic> json) =>
      HistorySakitModel(
        status: LeaveStatusX.fromString(json["status"]),
        reason: json["reason"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        decidedAt: json['decided_at'] != null
            ? DateTime.parse(json["decided_at"])
            : null,
      );
}

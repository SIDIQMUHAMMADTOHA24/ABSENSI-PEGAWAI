import 'package:absensi_pegawai/features/absensi/domain/entities/item.dart';

class ItemModel extends Item {
  ItemModel({
    required super.status,
    required super.reason,
    required super.startDate,
    required super.endDate,
    required super.createdAt,
    required super.decidedAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    status: json["status"],
    reason: json["reason"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    decidedAt: DateTime.parse(json["decided_at"]),
  );
}

import 'package:absensi_pegawai/features/absensi/domain/entities/history_cuti.dart';
import 'package:flutter/material.dart';

class HistoryCutiModel extends HistoryCuti {
  HistoryCutiModel({
    required super.status,
    required super.reason,
    required super.startDate,
    required super.endDate,
    required super.createdAt,
    required super.decidedAt,
  });

  factory HistoryCutiModel.fromJson(Map<String, dynamic> json) =>
      HistoryCutiModel(
        status: LeaveStatusX.fromString(json["status"]),
        reason: json["reason"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        decidedAt: DateTime.parse(json["decided_at"]),
      );
}

extension LeaveStatusX on LeaveStatus {
  String get name {
    switch (this) {
      case LeaveStatus.approved:
        return "approved";
      case LeaveStatus.rejected:
        return "rejected";
      case LeaveStatus.pending:
        return "pending";
    }
  }

  String get label {
    switch (this) {
      case LeaveStatus.approved:
        return "Approved";
      case LeaveStatus.rejected:
        return "Rejected";
      case LeaveStatus.pending:
        return "Pending";
    }
  }

  // contoh untuk UI (warna)
  MaterialColor get color {
    switch (this) {
      case LeaveStatus.approved:
        return Colors.green; // hijau
      case LeaveStatus.rejected:
        return Colors.red; // merah
      case LeaveStatus.pending:
        return Colors.amber; // kuning
    }
  }

  static LeaveStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case "approved":
        return LeaveStatus.approved;
      case "rejected":
        return LeaveStatus.rejected;
      case "pending":
        return LeaveStatus.pending;
      default:
        throw Exception("Unknown LeaveStatus: $value");
    }
  }
}

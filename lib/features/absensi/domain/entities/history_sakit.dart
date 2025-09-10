// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'history_cuti.dart';

class HistorySakit extends Equatable {
  LeaveStatus status;
  String reason;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime? decidedAt;
  HistorySakit({
    required this.status,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.decidedAt,
  });

  @override
  List<Object?> get props => [startDate, reason, endDate, createdAt, decidedAt];
}

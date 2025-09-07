// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum LeaveStatus { approved, rejected, pending }

class HistoryCuti extends Equatable {
  LeaveStatus status;
  String reason;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime? decidedAt;
  HistoryCuti({
    required this.status,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.decidedAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,
    reason,
    startDate,
    endDate,
    createdAt,
    decidedAt,
  ];
}

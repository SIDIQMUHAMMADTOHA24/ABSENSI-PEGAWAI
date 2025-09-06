import 'package:equatable/equatable.dart';

class Quota extends Equatable {
  final int year, quoraDay, usedDay, remainingDay;

  Quota({
    required this.year,
    required this.quoraDay,
    required this.usedDay,
    required this.remainingDay,
  });

  @override
  List<Object?> get props => [];
}

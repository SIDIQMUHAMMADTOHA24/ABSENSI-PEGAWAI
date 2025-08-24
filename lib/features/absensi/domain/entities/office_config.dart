import 'package:equatable/equatable.dart';

class OfficeConfig extends Equatable {
  final double lat, long;
  final int radiusM;
  final DateTime fetchedAt; // buat TTL

  const OfficeConfig({
    required this.lat,
    required this.long,
    required this.radiusM,
    required this.fetchedAt,
  });

  @override
  List<Object?> get props => [lat, long, radiusM, fetchedAt];
}

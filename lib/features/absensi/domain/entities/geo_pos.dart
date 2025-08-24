import 'package:equatable/equatable.dart';

class GeoPos extends Equatable {
  final double lat, long;
  final double? accuracyM;
  final DateTime timestamp;

  const GeoPos({
    required this.lat,
    required this.long,
    required this.accuracyM,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [lat, long, accuracyM, timestamp];
}

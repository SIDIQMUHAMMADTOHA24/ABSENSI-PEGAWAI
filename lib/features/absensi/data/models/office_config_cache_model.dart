import '../../domain/entities/office_config.dart';

class OfficeConfigCacheModel {
  final double officeLat;
  final double officeLng;
  final int radiusM;
  final DateTime fetchedAt;

  OfficeConfigCacheModel({
    required this.officeLat,
    required this.officeLng,
    required this.radiusM,
    required this.fetchedAt,
  });

  factory OfficeConfigCacheModel.fromJson(Map<String, dynamic> j) =>
      OfficeConfigCacheModel(
        officeLat: (j['office_lat'] as num).toDouble(),
        officeLng: (j['office_lng'] as num).toDouble(),
        radiusM: (j['radius_m'] as num).toInt(),
        fetchedAt: DateTime.parse(j['fetched_at'] as String),
      );

  Map<String, dynamic> toJson() => {
    'office_lat': officeLat,
    'office_lng': officeLng,
    'radius_m': radiusM,
    'fetched_at': fetchedAt.toIso8601String(),
  };

  OfficeConfig toEntity() => OfficeConfig(
    lat: officeLat,
    long: officeLng,
    radiusM: radiusM,
    fetchedAt: fetchedAt,
  );

  static OfficeConfigCacheModel fromEntity(OfficeConfig e) =>
      OfficeConfigCacheModel(
        officeLat: e.lat,
        officeLng: e.long,
        radiusM: e.radiusM,
        fetchedAt: e.fetchedAt,
      );
}

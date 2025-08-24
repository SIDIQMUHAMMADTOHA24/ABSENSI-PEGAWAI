import '../../domain/entities/office_config.dart';

class OfficeConfigModel {
  final double officeLat;
  final double officeLng;
  final int radiusM;

  OfficeConfigModel({
    required this.officeLat,
    required this.officeLng,
    required this.radiusM,
  });

  factory OfficeConfigModel.fromJson(Map<String, dynamic> j) =>
      OfficeConfigModel(
        officeLat: (j['office_lat'] as num).toDouble(),
        officeLng: (j['office_lng'] as num).toDouble(),
        radiusM: (j['radius_m'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
    'office_lat': officeLat,
    'office_lng': officeLng,
    'radius_m': radiusM,
  };

  /// Konversi ke entity, tambahkan timestamp saat diterima
  OfficeConfig toEntity(DateTime fetchedAt) => OfficeConfig(
    lat: officeLat,
    long: officeLng,
    radiusM: radiusM,
    fetchedAt: fetchedAt,
  );

  static OfficeConfigModel fromEntity(OfficeConfig e) => OfficeConfigModel(
    officeLat: e.lat,
    officeLng: e.long,
    radiusM: e.radiusM,
  );
}

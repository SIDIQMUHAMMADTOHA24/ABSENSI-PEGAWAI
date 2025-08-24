import 'dart:math';

double haversineMeters({
  required double lat1,
  required double lon1,
  required double lat2,
  required double lon2,
}) {
  const R = 6371000.0;
  final dLat = _d2r(lat2 - lat1), dLon = _d2r(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_d2r(lat1)) * cos(_d2r(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return R * c;
}

double _d2r(double d) => d * pi / 180.0;

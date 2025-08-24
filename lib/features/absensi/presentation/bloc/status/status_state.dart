part of 'status_bloc.dart';

class StatusState extends Equatable {
  final bool loading;
  final String? error;
  // user
  final double? userLat, userLng, userAccM;
  // office
  final double? officeLat, officeLng;
  final int? radiusM;
  // calc
  final double? distanceM;
  final bool? inside;

  const StatusState({
    this.loading = false,
    this.error,
    this.userLat,
    this.userLng,
    this.userAccM,
    this.officeLat,
    this.officeLng,
    this.radiusM,
    this.distanceM,
    this.inside,
  });

  StatusState copy({
    bool? loading,
    String? error,
    double? userLat,
    double? userLng,
    double? userAccM,
    double? officeLat,
    double? officeLng,
    int? radiusM,
    double? distanceM,
    bool? inside,
  }) => StatusState(
    loading: loading ?? this.loading,
    error: error,
    userLat: userLat ?? this.userLat,
    userLng: userLng ?? this.userLng,
    userAccM: userAccM ?? this.userAccM,
    officeLat: officeLat ?? this.officeLat,
    officeLng: officeLng ?? this.officeLng,
    radiusM: radiusM ?? this.radiusM,
    distanceM: distanceM ?? this.distanceM,
    inside: inside ?? this.inside,
  );

  @override
  List<Object?> get props => [
    loading,
    error,
    userLat,
    userLng,
    userAccM,
    officeLat,
    officeLng,
    radiusM,
    distanceM,
    inside,
  ];
}

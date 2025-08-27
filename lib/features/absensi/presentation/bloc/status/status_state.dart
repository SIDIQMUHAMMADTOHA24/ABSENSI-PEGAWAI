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
  final DateTime? todayDate;
  final DateTime? checkInAt;
  final bool loadingCheckIn;
  final DateTime? checkOutAt;
  final bool loadingCheckOut;
  final int? workedSeconds;
  final NextAction? nextAction;

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
    this.todayDate,
    this.checkInAt,
    this.checkOutAt,
    this.workedSeconds,
    this.nextAction,
    this.loadingCheckIn = false,
    this.loadingCheckOut = false,
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
    DateTime? todayDate,
    DateTime? checkInAt,
    DateTime? checkOutAt,
    int? workedSeconds,
    NextAction? nextAction,
    bool? loadingCheckIn,
    bool? loadingCheckOut,
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
    checkInAt: checkInAt ?? this.checkInAt,
    checkOutAt: checkOutAt ?? this.checkOutAt,
    workedSeconds: workedSeconds ?? this.workedSeconds,
    nextAction: nextAction ?? this.nextAction,
    loadingCheckIn: loadingCheckIn ?? this.loadingCheckIn,
    loadingCheckOut: loadingCheckOut ?? this.loadingCheckOut,
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
    todayDate,
    checkInAt,
    checkOutAt,
    workedSeconds,
    nextAction,
    loadingCheckIn,
    loadingCheckOut,
  ];
}

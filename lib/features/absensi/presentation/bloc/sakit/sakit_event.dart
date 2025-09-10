part of 'sakit_bloc.dart';

sealed class SakitEvent extends Equatable {
  const SakitEvent();

  @override
  List<Object> get props => [];
}

class GetHistorySakit extends SakitEvent {
  GetHistorySakit();
}

class SetPathAndBase64 extends SakitEvent {
  final String path;
  final String base64;

  SetPathAndBase64({required this.path, required this.base64});
  @override
  List<Object> get props => [path, base64];
}

class AddSakitEvent extends SakitEvent {
  final String reason;
  final String startDate;
  final String endDate;

  AddSakitEvent({
    required this.reason,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object> get props => [reason, startDate, endDate];
}

class ClearCacheSakit extends SakitEvent {
  final TextEditingController startSakitController;
  final TextEditingController endSakitController;
  final TextEditingController keteranganSakitController;

  ClearCacheSakit({
    required this.startSakitController,
    required this.endSakitController,
    required this.keteranganSakitController,
  });
  @override
  List<Object> get props => [
    startSakitController,
    endSakitController,
    keteranganSakitController,
  ];
}

class ClearPatchAndBase64 extends SakitEvent {
  ClearPatchAndBase64();
}

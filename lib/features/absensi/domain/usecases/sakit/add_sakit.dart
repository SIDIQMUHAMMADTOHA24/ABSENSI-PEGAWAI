import 'package:absensi_pegawai/features/absensi/domain/repositories/sakit_repository.dart';

class AddSakit {
  final SakitRepository repository;

  AddSakit(this.repository);

  Future<bool> call({
    required String reason,
    required String image,
    required String startDate,
    required String endDate,
  }) => repository.addSakit(
    reason: reason,
    image: image,
    startDate: startDate,
    endDate: endDate,
  );
}

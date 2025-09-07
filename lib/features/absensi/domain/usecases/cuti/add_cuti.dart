import '../../repositories/cuti_repository.dart';

class AddCuti {
  final CutiRepository repository;

  AddCuti(this.repository);

  Future<bool> call({
    required String reason,
    required String startDate,
    required String endDate,
  }) => repository.addCuti(
    reason: reason,
    startDate: startDate,
    endDate: endDate,
  );
}

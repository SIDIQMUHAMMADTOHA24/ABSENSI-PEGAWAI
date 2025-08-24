import '../entities/office_config.dart';

abstract class OfficeRepository {
  Future<OfficeConfig> get({bool forceRefresh = false});
}

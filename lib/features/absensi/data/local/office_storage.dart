import 'dart:convert';

import 'package:absensi_pegawai/features/absensi/data/models/office_config_cache_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OfficeStorage {
  final FlutterSecureStorage _s = FlutterSecureStorage();
  Future<void> saveLocation(OfficeConfigCacheModel model) async {
    await _s.write(
      key: 'office_config_json',
      value: jsonEncode(model.toJson()),
    );
  }

  Future<OfficeConfigCacheModel?> readLocation() async {
    var data = await _s.read(key: 'office_config_json');
    if (data == null) return null;
    return OfficeConfigCacheModel.fromJson(
      jsonDecode(data) as Map<String, dynamic>,
    );
  }
}

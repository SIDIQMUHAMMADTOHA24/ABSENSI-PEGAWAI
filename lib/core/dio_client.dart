import 'package:absensi_pegawai/core/access_token_holder.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/auth_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../features/absensi/data/local/token_storage.dart';

Dio buildDio(String baseUrl) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}

attachAuthInterceptors({
  required Dio dio,
  required AccessTokenHolder holder,
  required TokenStorage storage,
  required AuthRemoteDataSource authRemoteDataSource,
}) {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        String? t = holder.token;
        if (t != null && t.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $t';
        }
        handler.next(options);
      },

      onError: (error, handler) async {
        final is401 = error.response?.statusCode == 401; //UnAuthorized
        final isRefreshing = error.requestOptions.path == '/refresh';
        if (!is401 || isRefreshing) return handler.next(error);

        String? rft = await storage.readRefreshToken();
        if (rft == null || rft.isEmpty) return handler.next(error);

        try {
          final fresh = await authRemoteDataSource.refresh(rft);
          holder.set(fresh.accessToken);
          await storage.saveRefreshToken(fresh.refreshToken);

          final req = error.requestOptions;

          final response = await dio.request(
            req.path,
            data: req.data,
            queryParameters: req.queryParameters,
            options: Options(
              method: req.method,
              headers: {
                ...req.headers,
                'Authorization': 'Bearer ${fresh.accessToken}',
              },
            ),
          );

          return handler.resolve(response);
        } catch (e) {
          await storage.deleteRefreshToken();
          holder.clear();
          return handler.next(error);
        }
      },
    ),
  );
}

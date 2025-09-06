import 'package:absensi_pegawai/core/access_token_holder.dart';
import 'package:absensi_pegawai/core/dio_client.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/attendance_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/auth_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/cuti_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/location_local_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/datasources/user_remote_data_source.dart';
import 'package:absensi_pegawai/features/absensi/data/local/office_storage.dart';
import 'package:absensi_pegawai/features/absensi/data/local/token_storage.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/attendance_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/auth_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/cuti_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/location_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/session_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/data/repositories/user_repository_impl.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/attendance_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/auth_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/cuti_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/location_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/office_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/repositories/user_repository.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/absensi/ensure_permission.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/absensi/get_current_pos.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/absensi/get_office_config.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/absensi/watch_position.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/attendance/check_in.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/attendance/check_out.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/attendance/get_attendance_day.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/attendance/get_attendance_status.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/auth/login.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/auth/logout.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/auth/register.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/cuti/quota_cuti.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/delete_refresh_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/read_refresh_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/session/save_refresh_token.dart';
import 'package:absensi_pegawai/features/absensi/domain/usecases/user/get_user.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/calender/calender_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/cuti/cuti_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/status/status_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/user/user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/absensi/data/datasources/office_remote_data_source.dart';
import 'features/absensi/data/repositories/office_repository_impl.dart';
import 'features/absensi/domain/repositories/session_repository.dart';
import 'features/absensi/domain/usecases/attendance/get_attendance_marks.dart';

final sl = GetIt.I;

Future<void> injectDI() async {
  //CORE
  sl.registerLazySingleton(() => AccessTokenHolder());
  sl.registerLazySingleton<Duration>(() => Duration(hours: 12));

  //BASE DIO
  sl.registerLazySingleton<Dio>(
    () => buildDio('https://absensi-pegawai.up.railway.app'),
  );

  //DATA SOURCE
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<Dio>()));
  sl.registerLazySingleton(() => UserRemoteDataSource(sl<Dio>()));
  sl.registerLazySingleton(() => LocationLocalDataSource());
  sl.registerLazySingleton(() => OfficeRemoteDataSource(sl<Dio>()));
  sl.registerLazySingleton(() => AttendanceRemoteDataSource(sl<Dio>()));
  sl.registerLazySingleton(() => CutiRemoteDataSource(sl<Dio>()));

  //LOCAL
  sl.registerLazySingleton(() => TokenStorage());
  sl.registerLazySingleton(() => OfficeStorage());

  //INTERCEPTOR
  attachAuthInterceptors(
    dio: sl<Dio>(),
    holder: sl<AccessTokenHolder>(),
    storage: sl<TokenStorage>(),
    authRemoteDataSource: sl<AuthRemoteDataSource>(),
  );

  //REPOSITORY
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<OfficeRepository>(
    () => OfficeRepositoryImpl(
      local: sl<OfficeStorage>(),
      remote: sl<OfficeRemoteDataSource>(),
      ttl: sl<Duration>(),
    ),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CutiRepository>(() => CutiRepositoryImpl(sl()));

  //USE CASE
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => DeleteRefreshToken(sl()));
  sl.registerLazySingleton(() => ReadRefreshToken(sl()));
  sl.registerLazySingleton(() => SaveRefreshToken(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => EnsurePermission(sl()));
  sl.registerLazySingleton(() => GetCurrentPos(sl()));
  sl.registerLazySingleton(() => GetOfficeConfig(sl()));
  sl.registerLazySingleton(() => WatchPosition(sl()));
  sl.registerLazySingleton(() => CheckIn(sl()));
  sl.registerLazySingleton(() => CheckOut(sl()));
  sl.registerLazySingleton(() => GetAttendanceStatus(sl()));
  sl.registerLazySingleton(() => GetAttendanceMarks(sl()));
  sl.registerLazySingleton(() => GetAttendanceDay(sl()));
  sl.registerLazySingleton(() => QuotaCuti(sl()));

  //BLOC
  sl.registerFactory(
    () => AuthBloc(
      loginUC: sl<Login>(),
      registerUC: sl<Register>(),
      logoutUC: sl<Logout>(),
      readRefreshTokenUC: sl<ReadRefreshToken>(),
      saveRefreshTokenUC: sl<SaveRefreshToken>(),
      deleteRefreshTokenUC: sl<DeleteRefreshToken>(),
    ),
  );
  sl.registerFactory(() => UserBloc(sl<GetUser>()));
  sl.registerFactory(
    () => StatusBloc(
      ensurePermission: sl<EnsurePermission>(),
      getCurrentPos: sl<GetCurrentPos>(),
      watchPosition: sl<WatchPosition>(),
      getOfficeConfig: sl<GetOfficeConfig>(),
      checkIn: sl<CheckIn>(),
      checkOut: sl<CheckOut>(),
      getAttendanceStatus: sl<GetAttendanceStatus>(),
    ),
  );
  sl.registerFactory(
    () => CalenderBloc(sl<GetAttendanceMarks>(), sl<GetAttendanceDay>()),
  );

  sl.registerFactory(() => CutiBloc(sl<QuotaCuti>()));
}

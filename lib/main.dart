import 'package:absensi_pegawai/features/absensi/presentation/bloc/calender/calender_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/cuti/cuti_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/sakit/sakit_bloc.dart';
import 'package:absensi_pegawai/inject.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/access_token_holder.dart';
import 'features/absensi/data/datasources/auth_remote_data_source.dart';
import 'features/absensi/data/local/token_storage.dart';
import 'features/absensi/presentation/bloc/auth/auth_bloc.dart';
import 'features/absensi/presentation/bloc/status/status_bloc.dart';
import 'features/absensi/presentation/bloc/user/user_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_US', 'id_ID');

  await injectDI();
  await _bootstrapAuth();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<UserBloc>()..add(GetUserEvent())),
        BlocProvider(create: (_) => sl<StatusBloc>()..add(Init())),
        BlocProvider(
          create: (_) =>
              sl<CalenderBloc>()..add(LoadMonth(monthAnchor: DateTime.now())),
        ),
        BlocProvider(
          create: (_) => sl<CutiBloc>()
            ..add(GetQuotaCuti())
            ..add(GetHistoryCuti()),
        ),
        BlocProvider(create: (_) => sl<SakitBloc>()..add(GetHistorySakit())),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> _bootstrapAuth() async {
  final storage = sl<TokenStorage>();
  final holder = sl<AccessTokenHolder>();
  final auth = sl<AuthRemoteDataSource>();

  final rft = await storage.readRefreshToken();
  if ((rft ?? '').isEmpty) return;

  try {
    final fresh = await auth.refresh(rft!);
    holder.set(fresh.accessToken); // isi access token utk request awal
    await storage.saveRefreshToken(fresh.refreshToken); // putar refresh token
  } catch (_) {
    await storage.deleteRefreshToken();
    holder.clear();
  }
}

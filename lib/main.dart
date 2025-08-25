import 'package:absensi_pegawai/inject.dart';

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

  await injectDI();
  await _bootstrapAuth();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<UserBloc>()..add(GetUserEvent())),
        BlocProvider(create: (_) => sl<StatusBloc>()..add(Init())),
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
    // kalau gagal refresh di boot, anggap sesi mati
    await storage.deleteRefreshToken();
    holder.clear();
  }
}

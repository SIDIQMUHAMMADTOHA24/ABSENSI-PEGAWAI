import 'package:absensi_pegawai/features/absensi/data/local/token_storage.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/status/status_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/bloc/user/user_bloc.dart';

import 'package:absensi_pegawai/features/absensi/presentation/pages/login_pages.dart';
import 'package:absensi_pegawai/features/absensi/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:absensi_pegawai/inject.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/absensi/presentation/bloc/auth/auth_bloc.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await injectDI();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
        future: sl<TokenStorage>().readRefreshToken(),
        builder: (context, snap) {
          return (snap.hasData) ? BottomNavBarWidget() : LoginPages();
        },
      ),
    );
  }
}

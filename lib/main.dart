import 'package:absensi_pegawai/bloc/attendance/attendance_bloc.dart';
import 'package:absensi_pegawai/repository/attendance_repository.dart';
import 'package:absensi_pegawai/views/dashboard_view.dart';
import 'package:absensi_pegawai/views/login_view.dart';
import 'package:absensi_pegawai/views/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AttendanceBloc(AttendanceRepository())..add(AppStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LoginView(),
      ),
    );
  }
}

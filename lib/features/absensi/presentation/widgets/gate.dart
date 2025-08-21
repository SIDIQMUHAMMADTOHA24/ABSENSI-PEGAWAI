import 'package:absensi_pegawai/features/absensi/presentation/bloc/session/session_bloc.dart';
import 'package:absensi_pegawai/features/absensi/presentation/pages/login_pages.dart';
import 'package:absensi_pegawai/features/absensi/presentation/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gate extends StatelessWidget {
  const Gate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is SessionAuthenticated) {
          return const BottomNavBarWidget();
        }
        if (state is SessionUnauthenticated) {
          return const LoginPages();
        }
        return LoginPages();
      },
    );
  }
}

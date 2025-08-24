import 'package:absensi_pegawai/features/absensi/presentation/pages/login_pages.dart';
import 'package:absensi_pegawai/features/absensi/presentation/widgets/nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/user/user_bloc.dart';

class ProfilePages extends StatelessWidget {
  const ProfilePages({super.key});

  String ellipseMiddle(String s, {int head = 4, int tail = 4}) {
    if (s.length <= head + tail + 3) return s;
    return '${s.substring(0, head)}...${s.substring(s.length - tail)}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.paddingOf(context).top + 40),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return SliverToBoxAdapter(
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.person_alt_circle_fill,
                    size: 180,
                    color: Color(0xff343c60),
                  ),
                  SizedBox(height: 20),
                  Text(
                    (state is UserSuccess) ? state.data.username : "",
                    style: const TextStyle(
                      color: Color(0xffE5E7EB),
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      (state is UserSuccess)
                          ? ellipseMiddle(state.data.id)
                          : "",
                      style: const TextStyle(
                        color: Color(0xff9CA3AF),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    (state is UserSuccess) ? state.data.jabatan : "",
                    style: const TextStyle(
                      color: Color(0xff9CA3AF),
                      fontSize: 16,
                    ),
                  ),

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLogOut) {
                        Nav.remove(context, LoginPages());
                      }
                    },
                    child: menuWidget(
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget menuWidget({Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Material(
        color: Color.fromARGB(142, 52, 60, 96),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          focusColor: Color.fromARGB(142, 52, 60, 96),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logout',
                  style: const TextStyle(
                    color: Color(0xffE5E7EB),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  CupertinoIcons.forward,
                  color: Color.fromARGB(63, 229, 231, 235),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

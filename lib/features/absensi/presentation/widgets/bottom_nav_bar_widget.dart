import 'package:absensi_pegawai/features/absensi/presentation/pages/dashboard_pages.dart';
import 'package:absensi_pegawai/features/absensi/presentation/pages/profile_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/attendance_pages.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget({super.key});

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10122a),
      body: IndexedStack(
        index: _index,
        children: [DashboardPages(), AttendancePages(), ProfilePages()],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: (i) => setState(() => _index = i),
          backgroundColor: Colors.transparent,
          currentIndex: _index,
          unselectedItemColor: Color.fromARGB(181, 72, 52, 119),
          selectedItemColor: Color.fromARGB(255, 110, 79, 183),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

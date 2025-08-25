import 'package:flutter/material.dart';

import 'features/absensi/data/local/token_storage.dart';
import 'features/absensi/presentation/pages/login_pages.dart';
import 'features/absensi/presentation/widgets/bottom_nav_bar_widget.dart';
import 'inject.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
        future: sl<TokenStorage>().readRefreshToken(),
        builder: (context, snap) {
          final hasRft = (snap.data?.isNotEmpty == true);
          return hasRft ? const BottomNavBarWidget() : const LoginPages();
        },
      ),
    );
  }
}

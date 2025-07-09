import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constant/utils/state_enum.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/views/login_page.dart';
import 'features/customers/views/dashboard_customer_page.dart';
import 'features/koor_teknis/views/dashboard_koor_teknis.dart';
import 'features/marketing/views/dashboard_marketing.dart';
import 'features/penyedia_sampling/views/dashboard_penyedia_sampling.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  // Di _checkLogin() pada SplashScreen
  Future<void> _checkLogin() async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await authNotifier.checkLogin(); // Pastikan ada await disini

    Timer(const Duration(seconds: 3), () {
      if (authNotifier.user == null &&
          authNotifier.stateuser == UserStatus.isNotReady) {
        // Sekarang state sudah terupdate
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else if (authNotifier.user!.role == 'customer') {
        Navigator.pushReplacementNamed(
          context,
          DashboardCustomerPage.routeName,
        );
      } else if (authNotifier.user!.role == 'marketing') {
        // Navigator.pushReplacementNamed(context, DashboardMarketing.routeName);
      } else if (authNotifier.user!.role == 'koor teknis') {
        Navigator.pushReplacementNamed(context, DashboardKoorTeknis.routeName);
      } else if (authNotifier.user!.role == 'penyedia sampling') {
        Navigator.pushReplacementNamed(context, DashboardPenyediaSampling.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/mitral.png')));
  }
}

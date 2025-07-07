import 'dart:async';

import 'package:flutter/material.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/auth/views/login_page.dart';
import 'features/customers/features/dashboard/views/dashboard_customer_page.dart';
import 'package:provider/provider.dart';

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

  Future<void> _checkLogin() async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await authNotifier.checkLogin();
    Timer(const Duration(seconds: 3), () {
      if (authNotifier.user != null && authNotifier.user!.token!.isNotEmpty) {
        Navigator.pushReplacementNamed(
          context,
          DashboardCustomerPage.routeName,
        );
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/mitral.png')));
  }
}

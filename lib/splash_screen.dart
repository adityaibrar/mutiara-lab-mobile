import 'dart:async';

import 'package:flutter/material.dart';

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

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, '/login-page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/mitral.png')));
  }
}

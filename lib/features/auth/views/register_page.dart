import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constant/theme.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/input_field.dart';
import 'login_page.dart';

// Halaman Register
class RegisterPage extends StatefulWidget {
  static const String routeName = '/register-page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SizedBox(height: 60.h),
          headers(),
          SizedBox(height: 20.h),
          InputField(
            controller: _usernameController,
            label: 'Username',
            isPassword: false,
          ),
          SizedBox(height: 18.h),
          InputField(
            controller: _passwordController,
            label: 'Password',
            isPassword: true,
          ),
          SizedBox(height: 30.h),
          CustomButton(onPressed: () {}, label: 'Daftar'),
          SizedBox(height: 10.h),
          footer(),
        ],
      ),
    );
  }

  Widget headers() {
    return Center(
      child: Column(
        spacing: 60,
        children: [
          Image.asset('assets/mitral.png'),
          Text(
            'Buat Akun Baru',
            style: blackTextStyle.copyWith(
              color: blackColor,
              fontSize: 20.sp,
              fontWeight: bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: blackTextStyle.copyWith(fontSize: 14.sp), // gaya default
          children: [
            const TextSpan(text: 'Sudah punya akun? '),
            TextSpan(
              text: 'login',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

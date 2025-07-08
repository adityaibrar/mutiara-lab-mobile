import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/helpers/dialog_helper.dart';
import '../../../constant/theme.dart';
import '../../../constant/utils/state_enum.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/input_field.dart';
import '../../customers/views/dashboard_customer_page.dart';
import '../providers/auth_provider.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

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
          Consumer<AuthNotifier>(
            builder: (context, authNotifier, child) {
              if (authNotifier.state == RequestState.loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.showLoadingDialog(context);
                });
              }
              if (authNotifier.state == RequestState.loaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.hideLoadingDialog(context);
                  Navigator.pushReplacementNamed(
                    context,
                    DashboardCustomerPage.routeName,
                  );
                });
              }
              if (authNotifier.state == RequestState.error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  DialogHelper.hideLoadingDialog(context);
                  CustomSnackbar(
                    title: 'Error',
                    message: 'username atau password yang anda masukkan salah',
                    type: SnackbarType.error,
                  ).show(context);
                });
              }
              return CustomButton(
                onPressed: () async {
                  await authNotifier.login(
                    username: _usernameController.text,
                    password: _passwordController.text,
                  );
                },
                label: 'Masuk',
              );
            },
          ),
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
            'Login',
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
            const TextSpan(text: 'Belum punya akun? '),
            TextSpan(
              text: 'register',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushReplacementNamed(
                    context,
                    RegisterPage.routeName,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

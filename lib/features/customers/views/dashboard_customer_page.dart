import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/theme.dart';
import '../../../widgets/button_glass.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/views/login_page.dart';
import 'form_request_message.dart';

class DashboardCustomerPage extends StatelessWidget {
  static const String routeName = '/dashboard-customer-page';
  const DashboardCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Customer')),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Selamat Datang!',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: bold,
                      ),
                    ),
                    Text(
                      'Silahkan pilih menu dibawah ini',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              ButtonGlass(
                title: 'Lihat Surat Permintaan',
                onTap: () {
                  print('lihat');
                },
              ),
              SizedBox(height: 10.h),
              ButtonGlass(
                title: 'Form Surat Permintaan',
                onTap: () {
                  Navigator.pushNamed(context, FormRequestMessage.routeName);
                },
              ),
              SizedBox(height: 10.h),
              ButtonGlass(
                title: 'PO/TTd Quotation Lab MLM',
                onTap: () {
                  print('quotation');
                },
              ),
              SizedBox(height: 10.h),
              ButtonGlass(
                title: 'Logout',
                onTap: () async {
                  await context.read<AuthNotifier>().logout();
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constant/theme.dart';
import '../../../widgets/button_glass.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/views/login_page.dart';
import 'list_document_quotation.dart';
import 'list_dokumen_user_marketing.dart';

class DashboardMarketing extends StatelessWidget {
  static const String routeName = '/dashboard-marketing';
  const DashboardMarketing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard Marketing')),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                  title: 'List Dokumen User',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ListDokumenUserMarketing.routeName,
                    );
                  },
                ),
                SizedBox(height: 10.h),
                ButtonGlass(
                  title: 'List Dokumen Quotation',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ListDocumentQuotation.routeName,
                    );
                  },
                ),
                SizedBox(height: 10.h),
                ButtonGlass(
                  title: 'Logout',
                  onTap: () async {
                    Navigator.pushReplacementNamed(
                      context,
                      LoginPage.routeName,
                    );
                    await context.read<AuthNotifier>().logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

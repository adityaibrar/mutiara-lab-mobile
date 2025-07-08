import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mutiara_lab/features/customers/providers/image_provider.dart';
import 'package:provider/provider.dart';

import 'constant/route.dart';
import 'constant/theme.dart';
import 'features/auth/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => ImageNotifier()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
                titleTextStyle: whiteTextStyle.copyWith(fontSize: 18.sp),
                iconTheme: IconThemeData(color: whiteColor),
              ),
            ),
            routes: routes,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}

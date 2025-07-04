import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../splash_screen.dart';

dynamic routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
};

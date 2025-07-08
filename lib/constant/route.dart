import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../features/customers/views/dashboard_customer_page.dart';
import '../features/customers/views/form_request_message.dart';
import '../splash_screen.dart';

dynamic routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  DashboardCustomerPage.routeName: (context) => DashboardCustomerPage(),
  FormRequestMessage.routeName: (context) => FormRequestMessage(),
};

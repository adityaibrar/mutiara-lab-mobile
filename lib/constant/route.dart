import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../features/customers/views/dashboard_customer_page.dart';
import '../features/customers/views/detail_document_user.dart';
import '../features/customers/views/form_request_message.dart';
import '../features/customers/views/list_album_document_page.dart';
import '../features/customers/views/list_document_user.dart';
import '../features/koor_teknis/views/dashboard_koor_teknis.dart';
import '../features/koor_teknis/views/list_dokumen_user_teknis.dart';
import '../features/marketing/views/dashboard_marketing.dart';
import '../features/marketing/views/list_document_quotation.dart';
import '../features/marketing/views/list_dokumen_user_marketing.dart';
import '../features/penyedia_sampling/views/dashboard_penyedia_sampling.dart';
import '../features/penyedia_sampling/views/list_survey_lapangan.dart';
import '../splash_screen.dart';

dynamic routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  DashboardCustomerPage.routeName: (context) => DashboardCustomerPage(),
  FormRequestMessage.routeName: (context) => FormRequestMessage(),
  ListAlbumDocumentPage.routeName: (context) => ListAlbumDocumentPage(),
  ListDocumentUser.routeName: (context) => ListDocumentUser(),
  DetailDocumentUser.routeName: (context) => DetailDocumentUser(),
  DashboardMarketing.routeName: (context) => DashboardMarketing(),
  ListDokumenUserMarketing.routeName: (context) => ListDokumenUserMarketing(),
  ListDocumentQuotation.routeName: (context) => ListDocumentQuotation(),
  DashboardKoorTeknis.routeName: (context) => DashboardKoorTeknis(),
  ListDokumenUserTeknis.routeName: (context) => ListDokumenUserTeknis(),
  DashboardPenyediaSampling.routeName: (context) => DashboardPenyediaSampling(),
  ListSurveyLapangan.routeName: (context) => ListSurveyLapangan(),
};

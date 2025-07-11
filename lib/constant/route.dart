import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../features/customers/views/dashboard_customer_page.dart';
import '../features/customers/views/detail_document_user.dart';
import '../features/customers/views/detail_quotation_user.dart';
import '../features/customers/views/form_request_message.dart';
import '../features/customers/views/list_album_document_page.dart';
import '../features/customers/views/list_document_user.dart';
import '../features/customers/views/list_quotation_user.dart';
import '../features/customers/views/upload_document_invoice.dart';
import '../features/koor_teknis/views/dashboard_koor_teknis.dart';
import '../features/koor_teknis/views/detail_document_koor.dart';
import '../features/koor_teknis/views/list_dokumen_user_teknis.dart';
import '../features/koor_teknis/views/upload_document_koor.dart';
import '../features/marketing/views/dashboard_marketing.dart';
import '../features/marketing/views/detail_document_marketing.dart';
import '../features/marketing/views/detail_document_quotation.dart';
import '../features/marketing/views/list_document_quotation.dart';
import '../features/marketing/views/list_dokumen_user_marketing.dart';
import '../features/marketing/views/upload_document_marketing.dart';
import '../features/marketing/views/upload_document_pottd.dart';
import '../features/penyedia_sampling/views/dashboard_penyedia_sampling.dart';
import '../features/penyedia_sampling/views/detail_document_penyedia_sampling.dart';
import '../features/penyedia_sampling/views/list_survey_lapangan.dart';
import '../features/penyedia_sampling/views/upload_document_penyedia_sampling.dart';
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
  ListQuotationUser.routeName: (context) => ListQuotationUser(),
  DetailQuotationUser.routeName: (context) => DetailQuotationUser(),
  UploadDocumentInvoice.routeName: (context) => UploadDocumentInvoice(),
  DashboardMarketing.routeName: (context) => DashboardMarketing(),
  ListDokumenUserMarketing.routeName: (context) => ListDokumenUserMarketing(),
  DetailDocumentMarketing.routeName: (context) => DetailDocumentMarketing(),
  DetailDocumentQuotation.routeName: (context) => DetailDocumentQuotation(),
  UploadDocumentMarketing.routeName: (context) => UploadDocumentMarketing(),
  UploadDocumentPottd.routeName: (context) => UploadDocumentPottd(),
  ListDocumentQuotation.routeName: (context) => ListDocumentQuotation(),
  DashboardKoorTeknis.routeName: (context) => DashboardKoorTeknis(),
  DetailDocumentKoor.routeName: (context) => DetailDocumentKoor(),
  UploadDocumentKoor.routeName: (context) => UploadDocumentKoor(),
  ListDokumenUserTeknis.routeName: (context) => ListDokumenUserTeknis(),
  DashboardPenyediaSampling.routeName: (context) => DashboardPenyediaSampling(),
  DetailDocumentPenyediaSampling.routeName: (context) =>
      DetailDocumentPenyediaSampling(),
  UploadDocumentPenyediaSampling.routeName: (context) =>
      UploadDocumentPenyediaSampling(),
  ListSurveyLapangan.routeName: (context) => ListSurveyLapangan(),
};

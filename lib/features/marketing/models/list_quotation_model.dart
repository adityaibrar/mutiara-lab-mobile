import 'package:mutiara_lab/features/customers/models/document_user.dart';

class ListQuotationModel {
  final int id;
  final String tglSurvey;
  final String documentPath;
  final String status;
  final DocumentUser? documentUser;

  ListQuotationModel({
    required this.id,
    required this.tglSurvey,
    required this.documentPath,
    required this.status,
    required this.documentUser,
  });

  factory ListQuotationModel.fromMap(Map<String, dynamic> data) {
    return ListQuotationModel(
      id: data['id'],
      tglSurvey: data['tgl_survey'],
      documentPath: data['document_path'],
      status: data['status'],
      documentUser: data['document'] != null
          ? DocumentUser.fromMap(data['document'] as Map<String, dynamic>)
          : null,
    );
  }
}

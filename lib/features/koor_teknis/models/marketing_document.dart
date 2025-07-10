import 'package:mutiara_lab/features/customers/models/document_user.dart';

class MarketingDocument {
  final int? id;
  final String? tglKajian;
  final String? status;
  final String? ketKajian;
  final String? documentPath;
  final DocumentUser? documentUser;

  MarketingDocument({
    this.id,
    this.tglKajian,
    this.status,
    this.ketKajian,
    this.documentPath,
    this.documentUser,
  });

  factory MarketingDocument.fromMap(Map<String, dynamic> data) {
    return MarketingDocument(
      id: data['id'],
      tglKajian: data['tgl_kajian'],
      status: data['status'],
      ketKajian: data['ket_kajian'],
      documentPath: data['document_path'],
      documentUser: data['document'] != null
          ? DocumentUser.fromMap(data['document'] as Map<String, dynamic>)
          : null,
    );
  }
}

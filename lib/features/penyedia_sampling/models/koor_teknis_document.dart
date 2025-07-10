import '../../koor_teknis/models/marketing_document.dart';

class KoorTeknisDocument {
  final int? id;
  final String? tglMasuk;
  final String? status;
  final String? documentPath;
  final MarketingDocument? documentMarketing;

  KoorTeknisDocument({
    this.id,
    this.tglMasuk,
    this.status,
    this.documentPath,
    this.documentMarketing,
  });

  factory KoorTeknisDocument.fromMap(Map<String, dynamic> data) {
    return KoorTeknisDocument(
      id: data['id'],
      tglMasuk: data['tgl_masuk'],
      status: data['status'],
      documentPath: data['document_path'],
      documentMarketing: data['marketing'] != null
          ? MarketingDocument.fromMap(data['marketing'] as Map<String, dynamic>)
          : null,
    );
  }
}

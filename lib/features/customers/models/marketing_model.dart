class MarketingModel {
  final int id;
  final String status;
  final String tglKajian;
  final String ketKajian;
  final String documentPath;

  MarketingModel({
    required this.id,
    required this.status,
    required this.tglKajian,
    required this.ketKajian,
    required this.documentPath,
  });

  factory MarketingModel.fromMap(Map<String, dynamic> data) {
    return MarketingModel(
      id: data['id'],
      status: data['status'],
      tglKajian: data['tgl_kajian'],
      ketKajian: data['ket_kajian'],
      documentPath: data['document_path'],
    );
  }
}

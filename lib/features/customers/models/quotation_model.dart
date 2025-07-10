class QuotationModel {
  final int id;
  final int samplingId;
  final int marketingId;
  final String tglAcc;
  final String ketAcc;

  QuotationModel({
    required this.id,
    required this.samplingId,
    required this.marketingId,
    required this.tglAcc,
    required this.ketAcc,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> data) {
    return QuotationModel(
      id: data['id'],
      samplingId: data['sampling_id'],
      marketingId: data['marketing_id'],
      tglAcc: data['tgl_acc'],
      ketAcc: data['ket_acc'],
    );
  }
}

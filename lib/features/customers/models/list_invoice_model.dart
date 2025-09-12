import 'marketing_model.dart';
import 'penyedia_sampling.dart';

class ListInvoiceModel {
  final int id;
  final String tglTtd;
  final String ketTtd;
  final MarketingModel? marketingModel;
  final PenyediaSampling? penyediaSampling;

  ListInvoiceModel({
    required this.id,
    required this.tglTtd,
    required this.ketTtd,
    this.marketingModel,
    this.penyediaSampling,
  });

  factory ListInvoiceModel.fromMap(Map<String, dynamic> data) {
    return ListInvoiceModel(
      id: data['id'],
      tglTtd: data['tgl_acc'],
      ketTtd: data['ket_acc'],
      marketingModel: data['marketing'] != null
          ? MarketingModel.fromMap(data['marketing'] as Map<String, dynamic>)
          : null,
      penyediaSampling: data['penyedia_sampling'] != null
          ? PenyediaSampling.fromMap(
              data['penyedia_sampling'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

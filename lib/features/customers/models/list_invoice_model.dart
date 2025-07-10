import 'document_user.dart';
import 'quotation_model.dart';

class ListInvoiceModel {
  final int id;
  final String tglTtd;
  final String ketTtd;
  final DocumentUser? documentUser;
  final QuotationModel? quotationModel;

  ListInvoiceModel({
    required this.id,
    required this.tglTtd,
    required this.ketTtd,
    this.documentUser,
    this.quotationModel,
  });

  factory ListInvoiceModel.fromMap(Map<String, dynamic> data) {
    return ListInvoiceModel(
      id: data['id'],
      tglTtd: data['tgl_ttd'],
      ketTtd: data['ket_ttd'],
      documentUser: data['document'] != null
          ? DocumentUser.fromMap(data['document'] as Map<String, dynamic>)
          : null,
      quotationModel: data['quotation'] != null
          ? QuotationModel.fromMap(data['quotation'] as Map<String, dynamic>)
          : null,
    );
  }
}

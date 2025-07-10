import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../constant/helpers/local_storage.dart';
import '../../../constant/url.dart';
import '../../customers/models/document_user.dart';
import '../models/list_quotation_model.dart';
import '../models/upload_document_marketing.dart';

class MarketingService {
  final LocalStorage _localStorage = LocalStorage();
  Future<List<DocumentUser>> getListDocument() async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse('${Appurl.fetchAlbumDocument}/document');
    final header = {'Authorization': 'Bearer ${user!.token}'};
    try {
      final response = await http.get(url, headers: header);
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed fetch album document user');
      }
      final dataDocument = responseData['data_document'];
      if (dataDocument == null || dataDocument is! List) {
        return [];
      }

      final result = dataDocument
          .map((item) => DocumentUser.fromMap(item))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> uploadDocumentMarketingService(
    int id,
    UploadDocumentMarketingModel uploadDocumentMarketing,
  ) async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse('${Appurl.marketingDocument}/$id');
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user!.token}';

      request.fields['tgl_kajian'] = uploadDocumentMarketing.tglKajian;
      request.fields['ket_kajian'] = uploadDocumentMarketing.ketKajian;
      request.fields['status'] = uploadDocumentMarketing.status;

      request.files.add(
        await http.MultipartFile.fromPath(
          'document_path',
          uploadDocumentMarketing.docPath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();

      if (response.statusCode != 200) {
        throw Exception('Gagal upload dokumen');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ListQuotationModel>> getListQuotationService() async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse(Appurl.samplingDocument);
    final header = {'Authorization': 'Bearer ${user!.token}'};
    try {
      final response = await http.get(url, headers: header);
      final responseData = jsonDecode(response.body);
      // print(responseData);
      if (response.statusCode != 200) {
        throw Exception('Failed fetch album document user');
      }
      final dataDocument = responseData['data sampling'];
      if (dataDocument == null || dataDocument is! List) {
        return [];
      }

      final result = dataDocument
          .map((item) => ListQuotationModel.fromMap(item))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> uploadPoTTD({
    required int id,
    required String date,
    required String subject,
  }) async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse('${Appurl.quotationDocument}/$id');
    final header = {'Authorization': 'Bearer ${user!.token}'};
    final body = {'tgl_ttd': date, 'ket_ttd': subject};
    try {
      final response = await http.post(url, headers: header, body: body);
      if (response.statusCode != 200) {
        throw Exception('Terjadi kesalah saat upload ttd quotation');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

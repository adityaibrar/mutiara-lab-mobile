import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

import '../../../constant/helpers/local_storage.dart';
import '../../../constant/url.dart';
import '../models/marketing_document.dart';
import '../models/upload_document_koorteknis.dart';

class KoorTeknisService {
  final LocalStorage _localStorage = LocalStorage();

  Future<List<MarketingDocument>> getListDocument() async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse(Appurl.marketingDocument);
    final header = {'Authorization': 'Bearer ${user!.token}'};
    try {
      final response = await http.get(url, headers: header);
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed fetch album document user');
      }
      final dataDocument = responseData['data_marketing'];
      if (dataDocument == null || dataDocument is! List) {
        return [];
      }

      final result = dataDocument
          .map((item) => MarketingDocument.fromMap(item))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> uploadDocumentTeknisService(
    int id,
    UploadDocumentKoorteknis uploadDocumentKoorteknis,
  ) async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse('${Appurl.koorTeknisDocument}/$id');
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user!.token}';

      request.fields['tgl_masuk'] = uploadDocumentKoorteknis.tglMasuk;
      request.fields['status'] = uploadDocumentKoorteknis.status;

      final fileExtension = path
          .extension(uploadDocumentKoorteknis.documentPath)
          .toLowerCase();
      MediaType mediaType;

      if (fileExtension == '.pdf') {
        mediaType = MediaType('application', 'pdf');
      } else {
        mediaType = MediaType('image', 'jpeg'); // default gambar
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'document_path',
          uploadDocumentKoorteknis.documentPath,
          contentType: mediaType,
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
}

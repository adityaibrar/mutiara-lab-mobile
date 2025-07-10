import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../constant/helpers/local_storage.dart';
import '../../../constant/url.dart';
import '../models/koor_teknis_document.dart';
import '../models/upload_document_penyedia_sampling_model.dart';

class PenyediaSamplingServices {
  final LocalStorage _localStorage = LocalStorage();
  Future<List<KoorTeknisDocument>> getListDocument() async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse(Appurl.koorTeknisDocument);
    final header = {'Authorization': 'Bearer ${user!.token}'};
    try {
      final response = await http.get(url, headers: header);
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed fetch album document user');
      }
      final dataDocument = responseData['data_koor_teknis'];
      if (dataDocument == null || dataDocument is! List) {
        return [];
      }

      final result = dataDocument
          .map((item) => KoorTeknisDocument.fromMap(item))
          .toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> uploadDocumentPenyediaSamplingService(
    int id,
    UploadDocumentPenyediaSamplingModel uploadDocumentPenyediaSampling,
  ) async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse('${Appurl.samplingDocument}/$id');
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user!.token}';
      print(request.headers['Authorization'] = 'Bearer ${user.token}');
      print(user.id);

      request.fields['tgl_survey'] = uploadDocumentPenyediaSampling.tglSurvey;
      request.fields['status'] = uploadDocumentPenyediaSampling.status;

      request.files.add(
        await http.MultipartFile.fromPath(
          'document_path',
          uploadDocumentPenyediaSampling.documentPath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print(responseData.toString());

      if (response.statusCode != 200) {
        throw Exception('Gagal upload dokumen');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

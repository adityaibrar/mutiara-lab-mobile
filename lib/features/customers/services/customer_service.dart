import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../constant/helpers/local_storage.dart';
import '../../../constant/url.dart';
import '../models/album_document.dart';
import '../models/upload_document_user.dart';

class CustomerService {
  final LocalStorage _localStorage = LocalStorage();
  Future<void> uploadDocumentCustomer(
    UploadDocumentUser uploadDocumentCustomer,
  ) async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse(Appurl.uploadRequest);
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer ${user!.token}';
      print(request.headers['Authorization'] = 'Bearer ${user.token}');
      print(user.id);

      request.fields['doc_name'] = uploadDocumentCustomer.docName;
      request.fields['doc_date'] = uploadDocumentCustomer.docDate;
      request.fields['doc_number'] = uploadDocumentCustomer.docNumber;
      request.fields['doc_desc'] = uploadDocumentCustomer.docDesc;
      request.fields['doc_year'] = uploadDocumentCustomer.docYear;

      request.files.add(
        await http.MultipartFile.fromPath(
          'image_path',
          uploadDocumentCustomer.imagePath,
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

  Future<List<AlbumDocument>> getAlbumDocument() async {
    final user = await _localStorage.getDataUser();
    final url = Uri.parse(
      '${Appurl.fetchAlbumDocument}/${user!.id}/document/album',
    );
    final header = {'Authorization': 'Bearer ${user.token}'};
    try {
      final response = await http.get(url, headers: header);
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed fetch album document user');
      }
      final dataAlbum = responseData['data_album'];
      if (dataAlbum == null || dataAlbum is! List) {
        return [];
      }

      final result = dataAlbum
          .map((item) => AlbumDocument.fromMap(item))
          .toList();
      return result;
    } catch (e) {
      throw (e.toString());
    }
  }
}

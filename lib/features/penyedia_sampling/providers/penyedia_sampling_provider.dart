import 'package:flutter/material.dart';

import '../../../constant/utils/state_enum.dart';
import '../models/koor_teknis_document.dart';
import '../models/upload_document_penyedia_sampling_model.dart';
import '../services/penyedia_sampling_services.dart';

class PenyediaSamplingNotifier with ChangeNotifier {
  final PenyediaSamplingServices _penyediaSamplingServices =
      PenyediaSamplingServices();

  RequestState _state = RequestState.empty;
  String? _errorMessage = '';
  List<KoorTeknisDocument> _listDocument = [];

  RequestState get state => _state;
  String? get errorMessage => _errorMessage;
  List<KoorTeknisDocument> get listDocument => _listDocument;

  Future<void> getDocumentUser() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _penyediaSamplingServices.getListDocument();
      _listDocument = result;
      _state = RequestState.loaded;
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> uploadDocument(
    int id,
    UploadDocumentPenyediaSamplingModel uploadDocumentPenyediaSampling,
  ) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _penyediaSamplingServices.uploadDocumentPenyediaSamplingService(
        id,
        uploadDocumentPenyediaSampling,
      );
      _state = RequestState.loaded;
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void resetState() {
    _state = RequestState.empty;
    notifyListeners();
  }
}

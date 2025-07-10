import 'package:flutter/material.dart';

import '../../../constant/utils/state_enum.dart';
import '../models/marketing_document.dart';
import '../models/upload_document_koorteknis.dart';
import '../services/koor_teknis_service.dart';

class KoorTeknisProvider with ChangeNotifier {
  final KoorTeknisService _koorTeknisService = KoorTeknisService();

  RequestState _state = RequestState.empty;
  String? _errorMessage = '';
  List<MarketingDocument> _listDocument = [];

  RequestState get state => _state;
  String? get errorMessage => _errorMessage;
  List<MarketingDocument> get listDocument => _listDocument;

  Future<void> getDocumentUser() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _koorTeknisService.getListDocument();
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
    UploadDocumentKoorteknis uploadDocumentKoorteknis,
  ) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _koorTeknisService.uploadDocumentTeknisService(
        id,
        uploadDocumentKoorteknis,
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

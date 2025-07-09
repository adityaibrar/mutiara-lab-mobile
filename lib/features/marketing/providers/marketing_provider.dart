import 'package:flutter/material.dart';

import '../../../constant/utils/state_enum.dart';
import '../../customers/models/document_user.dart';
import '../models/upload_document_marketing.dart';
import '../services/marketing_service.dart';

class MarketingNotifier with ChangeNotifier {
  final MarketingService _marketingService = MarketingService();

  RequestState _state = RequestState.empty;
  String? _errorMessage = '';
  List<DocumentUser> _listDocument = [];

  RequestState get state => _state;
  String? get errorMessage => _errorMessage;
  List<DocumentUser> get listDocument => _listDocument;

  Future<void> getDocumentUser() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _marketingService.getListDocument();
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
    UploadDocumentMarketingModel uploadDocumentMarketingModel,
  ) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _marketingService.uploadDocumentMarketingService(
        id,
        uploadDocumentMarketingModel,
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

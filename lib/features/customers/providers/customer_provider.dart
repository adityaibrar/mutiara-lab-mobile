import 'package:flutter/material.dart';

import '../../../constant/utils/state_enum.dart';
import '../models/album_document.dart';
import '../models/document_user.dart';
import '../models/upload_document_user.dart';
import '../services/customer_service.dart';

class CustomerNotifier with ChangeNotifier {
  final CustomerService _customerService = CustomerService();

  RequestState _state = RequestState.empty;
  String? _errorMessage = '';
  List<AlbumDocument> _listAlbum = [];
  List<DocumentUser> _listDocument = [];

  RequestState get state => _state;
  String? get errorMessage => _errorMessage;
  List<AlbumDocument> get listAlbum => _listAlbum;
  List<DocumentUser> get listDocument => _listDocument;

  Future<void> uploadDocument(UploadDocumentUser uploadDocumentCustomer) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _customerService.uploadDocumentCustomer(uploadDocumentCustomer);
      _state = RequestState.loaded;
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getAlbum() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _customerService.getAlbumDocument();
      _listAlbum = result;
      _state = RequestState.loaded;
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> getDocumentYear(int year) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _customerService.getListDocument(year);
      _listDocument = result;
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

import 'package:flutter/material.dart';

import '../../../constant/utils/state_enum.dart';
import '../models/upload_document_user.dart';
import '../services/customer_service.dart';

class CustomerNotifier with ChangeNotifier {
  final CustomerService _customerService = CustomerService();
  RequestState _state = RequestState.empty;
  String? _errorMessage = '';

  RequestState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> uploadDocument(UploadDocumentUser uploadDocumentCustomer) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _customerService.uploadDocumentCustomer(uploadDocumentCustomer);
      _state = RequestState.loaded;
      notifyListeners();
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

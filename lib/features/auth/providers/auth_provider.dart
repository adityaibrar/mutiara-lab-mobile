import 'package:flutter/foundation.dart';

import '../../../constant/helpers/local_storage.dart';
import '../../../constant/utils/state_enum.dart';
import '../models/auth_model.dart';
import '../services/auth_services.dart';

class AuthNotifier with ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();
  final AuthServices _authServices = AuthServices();

  RequestState _state = RequestState.empty;
  UserStatus _stateUser = UserStatus.isNotReady;
  String? _errorMessage;
  AuthModel? _user;

  String? get errorMessage => _errorMessage;
  RequestState get state => _state;
  UserStatus get stateuser => _stateUser;
  AuthModel? get user => _user;

  Future<void> register({
    required String username,
    required String password,
  }) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      await _authServices.authRegister(username, password);
      _state = RequestState.loaded;
      if (kDebugMode) {
        print('Berhasil register');
      }
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await _authServices.authLogin(
        username: username,
        password: password,
      );
      _user = result;
      await _localStorage.setDataUser(authModel: user!);
      _state = RequestState.loaded;
      _stateUser = UserStatus.isReady;
      if (kDebugMode) {
        print('Login berhasil');
      }
    } catch (e) {
      _state = RequestState.error;
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('Login gagal: $_errorMessage');
      }
    }
    notifyListeners();
  }

  Future<void> checkLogin() async {
    final result = await _localStorage.getDataUser();
    if (result != null && result.token!.isNotEmpty) {
      _user = result;
    } else {
      _user = null;
    }
    notifyListeners();
  }

  Future logout() async {
    await _localStorage.clearData();
    _user = null;
    _stateUser = UserStatus.isNotReady;
    notifyListeners();
  }

  void resetState() {
    _state = RequestState.empty;
    notifyListeners();
  }
}

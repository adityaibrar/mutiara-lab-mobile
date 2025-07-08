import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/models/auth_model.dart';

class LocalStorage {
  static const String _authData = 'user';
  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  Future<void> setDataUser({required AuthModel authModel}) async {
    final userData = jsonEncode((authModel).toJson());
    await _flutterSecureStorage.write(key: _authData, value: userData);
  }

  Future<AuthModel?> getDataUser() async {
    final userJson = await _flutterSecureStorage.read(key: _authData);
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return AuthModel.fromMap(userMap);
    }
    return null;
  }

  Future<void> clearData() async {
    await _flutterSecureStorage.deleteAll();
    print('berhasil dihapus');
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/auth_model.dart';
import '../../../constant/url.dart';

class AuthServices {
  Future<void> authRegister(String username, String password) async {
    final url = Uri.parse(Appurl.register);
    try {
      final requestBody = {'username': username, 'password': password};
      final response = await http.post(url, body: requestBody);
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AuthModel> authLogin({
    required String username,
    required String password,
  }) async {
    final url = Uri.parse(Appurl.login);
    try {
      final requestBody = {'username': username, 'password': password};
      final response = await http.post(url, body: requestBody);
      if (response.statusCode != 200) {
        throw Exception('Username atau password yang anda masukkan salah');
      }
      final responseData = json.decode(response.body);
      final userData = responseData['data_user'];
      final user = AuthModel(
        id: userData['id'],
        username: userData['username'],
        token: userData['token'],
      );
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

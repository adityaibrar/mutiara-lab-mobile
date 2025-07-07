class AuthModel {
  final int? id;
  final String? username;
  final String? token;
  final String? role;

  AuthModel({this.username, this.token, this.id, this.role});

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'token': token, 'role': role};
  }

  factory AuthModel.fromMap(Map<String, dynamic> data) {
    return AuthModel(
      id: data['id'],
      username: data['username'],
      token: data['token'],
      role: data['role'],
    );
  }
}

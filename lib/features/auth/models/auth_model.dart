class AuthModel {
  final String? id;
  final String? username;
  final String? token;

  AuthModel({this.username, this.token, this.id});

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'token': token};
  }

  factory AuthModel.fromMap(Map<String, dynamic> data) {
    return AuthModel(
      id: data['id'],
      username: data['username'],
      token: data['token'],
    );
  }
}

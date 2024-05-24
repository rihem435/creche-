class UserLoginModel {
  Token? token;
  User? user;

  UserLoginModel({this.token, this.user});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class User {
  String? sId;
  String? role;
  String? fullName;
  String? email;
  int? phone;
  String? adress;
  String? password;
  String? userName;
  List<dynamic>? children;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.role,
      this.fullName,
      this.email,
      this.phone,
      this.adress,
      this.password,
      this.userName,
      this.children,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    adress = json['adress'];
    password = json['password'];
    userName = json['userName'];

    children = json['children'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class UserModel {
  String? message;
  int? status;
  Data? data;

  UserModel({this.message, this.status, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
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
  String? refreshToken;

  Data(
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
      this.iV,
      this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
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
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['role'] = role;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['adress'] = adress;
    data['password'] = password;
    data['userName'] = userName;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

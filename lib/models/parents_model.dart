class ParentsModel {
  String? message;
  int? status;
  List<Data>? data;

  ParentsModel({this.message, this.status, this.data});

  ParentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  List<String>? children;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    adress = json['adress'];
    password = json['password'];
    userName = json['userName'];
    children = json['children'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['children'] = children;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

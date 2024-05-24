class ChildModel {
  String? message;
  int? status;
  Data? data;

  ChildModel({this.message, this.status, this.data});

  ChildModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  int? phone;
  String? photo;
  String? sex;
  String? program;
  String? birthdate;
  String? adress;
  String? category;
  List<String>? situations;
  List<String>? presences;
  String? parent;
  List<String>? activitychild;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.firstName,
      this.lastName,
      this.phone,
      this.photo,
      this.sex,
      this.program,
      this.birthdate,
      this.adress,
      this.category,
      this.situations,
      this.presences,
      this.parent,
      this.activitychild,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    photo = json['photo'];
    sex = json['sex'];
    program = json['program'];
    birthdate = json['birthdate'];
    adress = json['adress'];
    category = json['category'];
    situations = json['situations'].cast<String>();
    presences = json['presences'].cast<String>();
    parent = json['parent'];
    activitychild = json['activitychild'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['photo'] = photo;
    data['sex'] = sex;
    data['program'] = program;
    data['birthdate'] = birthdate;
    data['adress'] = adress;
    data['category'] = category;
    data['situations'] = situations;
    data['presences'] = presences;
    data['parent'] = parent;
    data['activitychild'] = activitychild;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

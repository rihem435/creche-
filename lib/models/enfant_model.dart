class EnfantModel {
  String? message;
  int? status;
  Data? data;

  EnfantModel({this.message, this.status, this.data});

  EnfantModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<dynamic>? situations;
  List<dynamic>? presences;
  String? parent;
    String? etablissement;

  List<dynamic>? activitychild;
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
      this.parent,this.etablissement,
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

    situations = json['situations'];

    presences = json['presences'];
    parent = json['parent'];
    etablissement = json['etablissement'];

    activitychild = json['activitychild'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

 

}

class ListEnfantsModel {
  String? message;
  int? status;
  List<Data>? data;

  ListEnfantsModel({this.message, this.status, this.data});

  ListEnfantsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
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
      this.parent,
      this.etablissement,
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
    etablissement = json['etablissement'];

    activitychild = json['activitychild'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

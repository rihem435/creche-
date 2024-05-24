class SituationModel {
  String? message;
  int? status;
  Data? data;

  SituationModel({this.message, this.status, this.data});

  SituationModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? name;
  String? treatment;
  String? description;
  String? child;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.type,
      this.name,
      this.treatment,
      this.description,
      this.child,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    name = json['name'];
    treatment = json['treatment'];
    description = json['description'];
    child = json['child'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['type'] = type;
    data['name'] = name;
    data['treatment'] = treatment;
    data['description'] = description;
    data['child'] = child;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

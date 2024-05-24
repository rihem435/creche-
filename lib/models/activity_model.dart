class ActivityModel {
  String? message;
  int? status;
  Data? data;

  ActivityModel({this.message, this.status, this.data});

  ActivityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  String? title;
  String? description;
  String? duration;
  String? photo;
  List<dynamic>? activitychild;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.title,
      this.description,
      this.duration,
      this.photo,
      this.activitychild,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    photo = json['photo'];

    activitychild = json['activitychild'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

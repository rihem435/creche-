class CategoriesModel {
  String? message;
  int? status;
  List<Data>? data;

  CategoriesModel({this.message, this.status, this.data});
  List<String> getCategoryNames() {
    List<String> categoryNames = [];
    if (data != null) {
      categoryNames = data!.map((data) => data.name!).toList();
    }
    return categoryNames;
  }

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  List<String>? children;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.name,
      this.children,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    children = json['children'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

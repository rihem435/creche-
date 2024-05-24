class AllMessagesModel {
  List<Data>? data;

  AllMessagesModel({this.data});

  AllMessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? text;
  String? senderId;
  String? receiverId;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
      this.text,
      this.senderId,
      this.receiverId,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

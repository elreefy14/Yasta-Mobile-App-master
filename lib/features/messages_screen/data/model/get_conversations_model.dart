class GetConversationsModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetConversationsModel({this.status, this.message, this.data});

  GetConversationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? name;
  String? lastMessage;
  int? noNewMessage;
  String? lastSentAt;
  bool? seen;

  Data(
      {this.id,
        this.image,
        this.name,
        this.lastMessage,
        this.noNewMessage,
        this.lastSentAt,
        this.seen});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    lastMessage = json['last_message'];
    noNewMessage = json['no_new_message'];
    lastSentAt = json['last_sent_at'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['last_message'] = this.lastMessage;
    data['no_new_message'] = this.noNewMessage;
    data['last_sent_at'] = this.lastSentAt;
    data['seen'] = this.seen;
    return data;
  }
}

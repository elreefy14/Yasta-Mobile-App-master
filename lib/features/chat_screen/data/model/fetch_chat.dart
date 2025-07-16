class FetchConversationsModel {
  bool? status;
  String? message;
  Data? data;

  FetchConversationsModel({this.status, this.message, this.data});

  FetchConversationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? workshopImage;
  String? workshopName;
  Messages? messages;

  Data({this.id, this.workshopImage, this.workshopName, this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshopImage = json['workshop_image'];
    workshopName = json['workshop_name'];
    messages = json['messages'] != null
        ? new Messages.fromJson(json['messages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workshop_image'] = this.workshopImage;
    data['workshop_name'] = this.workshopName;
    if (this.messages != null) {
      data['messages'] = this.messages!.toJson();
    }
    return data;
  }
}

class Messages {
  List<DataMessages>? dataMessages;
  Meta? meta;

  Messages({this.dataMessages, this.meta});

  Messages.fromJson(Map<String, dynamic> json) {
    if (json['data_messages'] != null) {
      dataMessages = <DataMessages>[];
      json['data_messages'].forEach((v) {
        dataMessages!.add(new DataMessages.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataMessages != null) {
      data['data_messages'] =
          this.dataMessages!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class DataMessages {
  int? id;
  String? type;
  bool? send_me;
  String? message;
  String? createdAt;

  DataMessages({this.id, this.type, this.message,this.send_me, this.createdAt});

  DataMessages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    message = json['message'];
    send_me = json['send_me'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['message'] = this.message;
    data['send_me'] = this.send_me;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Meta {
  dynamic linkNext;
  dynamic linkPrev;
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPages;

  Meta(
      {this.linkNext,
        this.linkPrev,
        this.total,
        this.count,
        this.perPage,
        this.currentPage,
        this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    linkNext = json['link_next'];
    linkPrev = json['link_prev'];
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link_next'] = this.linkNext;
    data['link_prev'] = this.linkPrev;
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    return data;
  }
}

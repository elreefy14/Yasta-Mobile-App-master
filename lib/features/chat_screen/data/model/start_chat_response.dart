class StartConversationsResponseModel {
  bool? status;
  String? message;
  Data? data;

  StartConversationsResponseModel({this.status, this.message, this.data});

  StartConversationsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? workshopId;
  int? userId;

  Data({this.id, this.workshopId, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workshopId = json['workshop_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['workshop_id'] = this.workshopId;
    data['user_id'] = this.userId;
    return data;
  }
}

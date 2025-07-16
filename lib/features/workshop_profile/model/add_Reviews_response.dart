class AddReviewsResponseModel {
  bool? status;
  String? message;
  Data? data;

  AddReviewsResponseModel({this.status, this.message, this.data});

  AddReviewsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? username;
  String? userImage;
  String? rate;
  String? comment;

  Data(
      {this.id,
        this.userId,
        this.username,
        this.userImage,
        this.rate,
        this.comment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
    userImage = json['user_image'];
    rate = json['rate'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['user_image'] = this.userImage;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    return data;
  }
}
